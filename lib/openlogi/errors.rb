require "openlogi/base_object"

module Openlogi
  class Errors < Hash
    include Hashie::Extensions::Coercion
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IndifferentAccess

    def full_messages
      values.join
    end
  end
end
