require "openlogi/api/endpoint"

module Openlogi
  module Api
    class Validations < Endpoint
      def resource_class
        Openlogi::Validation
      end

      def validate_recipient(params)
        perform_request_with_object(:post, "validations/recipient", { recipient: params })
      end

      def validate_sender(params)
        perform_request_with_object(:post, "validations/sender", { recipient: params })
      end
    end
  end
end
