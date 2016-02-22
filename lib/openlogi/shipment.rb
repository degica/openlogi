require "openlogi/base_object"
require "openlogi/delivery_options"

module Openlogi
  class Shipment < BaseObject
    attribute :id, String
    attribute :identifier, String
    attribute :created_at, DateTime
    attribute :shipped_at, DateTime
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
    attribute :delivery_options, Openlogi::DeliveryOptions
    attribute :gift_wrapping_unit, String
    attribute :gift_wrapping_type, String
    attribute :gift_sender_name, String
    attribute :bundled_items, Array[String]
    attribute :cash_on_delivery, Boolean
    attribute :shipping_email, String
    attribute :message, String
    attribute :status, String
    attribute :items, Array[Openlogi::Item]
  end
end
