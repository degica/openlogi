require "openlogi/errors"

module Openlogi
  class BaseObject < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IndifferentAccess

    def initialize(attributes = {}, &block)
      @attributes = attributes.to_hash.dup
      @attributes.each_key do |key|
        if !self.class.property?(key)
          @attributes.delete(key)
          warn "#{key} is not a property of #{self.class} and will be ignored."
        end
      end

      super(@attributes, &block)
    end

    property :error
    property :errors, coerce: Openlogi::Errors
    property :error_description

    def valid?
      error.nil? && (errors.nil? || errors.empty?)
    end
  end
end
