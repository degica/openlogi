require "openlogi/base_object"
require "openlogi/delivery_options"
require "openlogi/boolean"
require "openlogi/datetime"
require "openlogi/enum"

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
    property :delivery_method, coerce: Enum[:POST, :POST_EXPRESS, :HOME, :HOME_BOX]
    property :delivery_carrier, coerce: Enum[:YAMATO, :SAGAWA]
    property :delivery_time_slot, coerce: Enum[:AM, :'12', :'14', :'16', :'18', :'20']
    property :delivery_date, coerce: DateTime
    property :delivery_options, coerce: DeliveryOptions
    property :gift_wrapping_unit, coerce: Enum[:ORDER, :ITEM]
    property :gift_wrapping_type, coerce: Enum[:NAVY, :RED, :PINK, :BROWN, :WHITE]
    property :gift_sender_name
    property :bundled_items, coerce: Array[String]
    property :cash_on_delivery, coerce: Boolean
    property :shipping_email
    property :message
    property :status, coerce: Enum[:WAITING, :WORKING, :SHIPPED, :BACKORDERED]
    property :items, coerce: Array[Item]
    property :tracking_code
  end
end
