require "openlogi/base_object"
require "openlogi/stock"
require "openlogi/international_info"
require "openlogi/boolean"

module Openlogi
  class Item < BaseObject
    property :id
    property :code
    property :name
    property :price, coerce: Integer
    property :unit_price, coerce: Integer
    property :barcode
    property :international_info, coerce: InternationalInfo
    property :stock, coerce: Stock
    property :quantity, coerce: Integer
    property :backorder_if_unavailable, coerce: Boolean
  end
end
