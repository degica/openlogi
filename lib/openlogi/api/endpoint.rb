module Openlogi
  module Api
    class Endpoint
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def find(id)
        raise NotImplementedError
      end

      def all
        raise NotImplementedError
      end

      def update(id, params)
        raise NotImplementedError
      end

      def create(params)
        raise NotImplementedError
      end

      def destroy(id)
        raise NotImplementedError
      end

      def resource_class
        raise NotImplementedError
      end

      private

      def perform_request(method, resource, options = {})
        Openlogi::Request.new(client, method, resource, options).perform
      end

      def perform_request_with_object(method, resource, options)
        response = perform_request(method, resource, options)
        resource_class.new(response)
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
