module Openlogi
  module Api
    class Warehousings < Endpoint
      def resource_class
        Openlogi::Warehousing
      end

      def find(id)
        perform_request_with_object(:get, "warehousings/#{id}", {})
      end

      def all
        perform_request_with_objects(:get, "warehousings", {})
      end

      def update(id, params)
        perform_request_with_object(:put, "warehousings/#{id}", params)
      end

      def create(params)
        perform_request_with_object(:post, "warehousings", params)
      end

      def destroy(id)
        perform_request_with_object(:delete, "warehousings/#{id}", {})
      end
    end
  end
end
