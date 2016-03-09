module Openlogi
  module Api
    class Endpoint
      attr_reader :client

      def initialize(client)
        @client = client
      end

      %w[map each first last count size].each do |method_name|
        define_method method_name do |*args|
          forwarded = args.empty? ? send(:all) : send(:all, args[0])
          forwarded.send(method_name)
        end
      end

      def all(*args)
        raise NotImplementedError
      end

      def resource_class
        raise NotImplementedError
      end

      def perform_request(method, resource, options = {})
        Openlogi::Request.new(client, method, resource, options).perform.tap do |response|
          client.last_response = response
          response.validate!
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
