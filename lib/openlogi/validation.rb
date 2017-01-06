require "openlogi/base_object"

module Openlogi
  class Validation < BaseObject

    property :success, coerce: Boolean

    def initialize(response, &block)
      @attributes = {
        success: response.success?,
        error: response.error,
        errors: response.errors,
        error_description: response.error_description
      }
      super(@attributes, &block)
    end
  end
end
