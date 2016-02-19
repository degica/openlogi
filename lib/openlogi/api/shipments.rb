module Openlogi
  module Api
    class Shipments < Endpoint
      def find(id)
        perform_request_with_object(:get, "shipments/#{id}", {}, Openlogi::Shipment)
      end

      def all
        perform_request_with_objects(:get, "shipments", {}, Openlogi::Shipment)
      end

      def update(id, params)
        perform_request_with_object(:put, "shipments/#{id}", params, Openlogi::Shipment)
      end

      def create(params)
        perform_request_with_object(:post, "shipments", params, Openlogi::Shipment)
      end

      def destroy(id)
        perform_request_with_object(:delete, "shipments/#{id}", {}, Openlogi::Shipment)
      end
    end
  end
end
