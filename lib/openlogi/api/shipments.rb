module Openlogi
  module Api
    class Shipments < Endpoint
      def resource_class
        Openlogi::Shipment
      end

      def find(id)
        perform_request_with_object(:get, "shipments/#{id}", {})
      end

      def all
        perform_request_with_objects(:get, "shipments", {})
      end

      def update(id, params)
        perform_request_with_object(:put, "shipments/#{id}", params)
      end

      def create(params)
        perform_request_with_object(:post, "shipments", params)
      end

      def destroy(id)
        perform_request_with_object(:delete, "shipments/#{id}", {})
      end
    end
  end
end
