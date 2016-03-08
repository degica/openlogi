module Openlogi
  class BaseObject < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion
    include Hashie::Extensions::IndifferentAccess

    def initialize(attributes = {}, &block)
      attributes.each_key do |key|
        if !self.class.property?(key)
          attributes.delete(key)
          warn "#{key} is not a property of #{self.class} and will be ignored."
        end
      end

      super
    end

    property :error
    property :errors
    property :error_description

    def valid?
      errors.empty?
    end
  end
end
