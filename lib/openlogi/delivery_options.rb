require "openlogi/base_object"

module Openlogi
  class DeliveryOptions < BaseObject
    attribute :box_delivery, Boolean
    attribute :telephone, Boolean
    attribute :fragile_item, Boolean
  end
end
