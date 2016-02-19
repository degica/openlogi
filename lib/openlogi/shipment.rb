require "openlogi/base_object"

module Openlogi
  class Shipment < BaseObject
    attribute :id, String
    attribute :identifier, String
    attribute :created_at, DateTime
    attribute :order_no, String
    attribute :recipient, Openlogi::Address
    attribute :sender, Openlogi::Address
    attribute :subtotal_amount, Integer
    attribute :delivery_charge, Integer
    attribute :handling_charge, Integer
    attribute :discount_amount, Integer
    attribute :total_amount, Integer
    attribute :delivery_method, String
    attribute :delivery_carrier, String
    attribute :delivery_time_slot, String
    attribute :delivery_date, DateTime
    attribute :gift_wrapping_unit, String
    attribute :gift_warpping_type, String
    attribute :gift_sender_name, String
    attribute :bundled_items, Array[String]
    attribute :status, String
    attribute :items, Array[Item]
  end
end
