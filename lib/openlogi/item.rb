require "openlogi/base_object"
require "openlogi/stock"
require "openlogi/international_info"

module Openlogi
  class Item < BaseObject
    attribute :id, String
    attribute :code, String
    attribute :name, String
    attribute :price, Integer
    attribute :unit_price, Integer
    attribute :barcode, String
    attribute :international_info, Openlogi::InternationalInfo
    attribute :stock, Stock
    attribute :quantity, Integer
  end
end
