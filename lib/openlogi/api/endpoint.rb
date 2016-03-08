module Openlogi
  module Api
    class Endpoint
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def resource_class
        raise NotImplementedError
      end

      def perform_request(method, resource, options = {})
        Openlogi::Request.new(client, method, resource, options).perform.tap do |response|
          client.last_response = response
          raise BadRequestError.new(response) if response.bad_request?
        end
      end

      private

      def perform_request_with_object(method, resource, options)
        resource_class.new(perform_request(method, resource, options))
      end

      def perform_request_with_objects(method, resource, options)
        resource_key = resource.split('/').first
        perform_request(method, resource, options).fetch(resource_key, []).collect do |element|
          resource_class.new(element)
        end
      end
    end
  end
end
