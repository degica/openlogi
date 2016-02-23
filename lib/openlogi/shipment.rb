require "openlogi/base_object"
require "openlogi/delivery_options"
require "openlogi/boolean"
require "openlogi/datetime"

module Openlogi
  class Shipment < BaseObject
    property :id
    property :identifier
    property :created_at, coerce: DateTime
    property :shipped_at, coerce: DateTime
    property :order_no
    property :recipient, coerce: Address
    property :sender, coerce: Address
    property :subtotal_amount, coerce: Integer
    property :delivery_charge, coerce: Integer
    property :handling_charge, coerce: Integer
    property :discount_amount, coerce: Integer
    property :total_amount, coerce: Integer
    property :delivery_method
    property :delivery_carrier
    property :delivery_time_slot
    property :delivery_date, coerce: DateTime
    property :delivery_options, coerce: DeliveryOptions
    property :gift_wrapping_unit
    property :gift_wrapping_type
    property :gift_sender_name
    property :bundled_items, coerce: Array[String]
    property :cash_on_delivery, coerce: Boolean
    property :shipping_email
    property :message
    property :status
    property :items, coerce: Array[Item]
  end
end
