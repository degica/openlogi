require "openlogi/api/endpoint"

module Openlogi
  module Api
    class Items < Endpoint
      def find(id, stock: false)
        params = stock ? { stock: stock } : {}
        perform_request_with_object(:get, "items/#{id}", params, Openlogi::Item)
      end

      def all(stock: false)
        params = stock ? { stock: stock } : {}
        perform_request_with_objects(:get, "items", params, Openlogi::Item)
      end

      def update(id, params)
        perform_request_with_object(:put, "items/#{id}", params, Openlogi::Item)
      end

      def create(params)
        perform_request_with_object(:post, "items", params, Openlogi::Item)
      end

      def destroy(id)
        perform_request_with_object(:delete, "items/#{id}", {}, Openlogi::Item)
      end
    end
  end
end
