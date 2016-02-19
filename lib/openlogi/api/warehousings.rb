module Openlogi
  module Api
    class Warehousings < Endpoint
      def find(id)
        perform_request_with_object(:get, "warehousings/#{id}", {}, Openlogi::Warehousing)
      end

      def all
        perform_request_with_objects(:get, "warehousings", {}, Openlogi::Warehousing)
      end

      def update(id, params)
        perform_request_with_object(:put, "warehousings/#{id}", params, Openlogi::Warehousing)
      end

      def create(params)
        perform_request_with_object(:post, "warehousings", params, Openlogi::Warehousing)
      end

      def destroy(id)
        perform_request_with_object(:delete, "warehousings/#{id}", {}, Openlogi::Warehousing)
      end
    end
  end
end
