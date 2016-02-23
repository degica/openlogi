module Openlogi
  class BaseObject < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion
    include Hashie::Extensions::IndifferentAccess

    property :error
    property :errors
    property :error_description
  end
end
