require "openlogi/api/endpoint"

module Openlogi
  module Api
    class Items < Endpoint
      def resource_class
        Openlogi::Item
      end

      def find(id, stock: false)
        params = stock ? { stock: stock } : {}
        perform_request_with_object(:get, "items/#{id}", params)
      end

      def all(stock: false)
        params = stock ? { stock: stock } : {}
        perform_request_with_objects(:get, "items", params)
      end

      def update(id, params)
        perform_request_with_object(:put, "items/#{id}", params)
      end

      def create(params)
        perform_request_with_object(:post, "items", params)
      end

      def destroy(id)
        perform_request_with_object(:delete, "items/#{id}", {})
      end
    end
  end
end
