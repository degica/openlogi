require "openlogi/base_object"
require "openlogi/boolean"

module Openlogi
  class DeliveryOptions < BaseObject
    property :box_delivery, coerce: Boolean
    property :telephone, coerce: Boolean
    property :fragile_item, coerce: Boolean
  end
end
