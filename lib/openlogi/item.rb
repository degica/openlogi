require "openlogi/base_object"
require "openlogi/stock"
require "openlogi/international_info"
require "openlogi/image"
require "openlogi/boolean"

module Openlogi
  class Item < BaseObject
    property :id
    property :code
    property :name
    property :price, coerce: Integer
    property :unit_price, coerce: Integer
    property :barcode
    property :jancode
    property :international_info, coerce: InternationalInfo
    property :stock, coerce: Stock
    property :quantity, coerce: Integer
    property :gift_wrapping_type, coerce: Enum[:NAVY, :RED, :PINK, :BROWN, :WHITE]
    property :backorder_if_unavailable, coerce: Boolean
    property :images, coerce: Array[Image]
    property :serial_no
  end
end
