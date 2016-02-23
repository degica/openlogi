require "openlogi/base_object"

module Openlogi
  class InternationalInfo < BaseObject
    property :invoice_summary, coerce: String
  end
end
