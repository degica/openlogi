require "openlogi/api/endpoint"

module Openlogi
  module Api
    class Validations < Endpoint
      def resource_class
        Openlogi::Validation
      end

      def recipient(params)
        perform_request_with_object(:post, "validations/recipient", { recipient: params })
      end

      def sender(params)
        perform_request_with_object(:post, "validations/sender", { sender: params })
      end
    end
  end
end
