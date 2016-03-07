require "openlogi/response_error"

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

      private

      def perform_request(method, resource, options = {})
        Openlogi::Request.new(client, method, resource, options).perform.tap do |response|
          raise ResponseError.new(response) if response.invalid?
        end
      end

      def perform_request_with_object(method, resource, options)
        client.last_response = response = perform_request(method, resource, options)
        resource_class.new(response)
      end

      def perform_request_with_objects(method, resource, options)
        resource_key = resource.split('/').first
        client.last_response = response = perform_request(method, resource, options)
        response.fetch(resource_key, []).collect do |element|
          resource_class.new(element)
        end
      end
    end
  end
end
