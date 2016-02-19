require "openlogi/base_object"

module Openlogi
  class Shipment < BaseObject
    attribute :identifier, String
    attribute :order_no, String
    attribute :recipient, Openlogi::Address
    attribute :sender, Openlogi::Address
    attribute :items, Array[Item]
  end
end
