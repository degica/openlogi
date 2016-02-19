require "openlogi/base_object"
require "openlogi/stock"

module Openlogi
  class Item < BaseObject
    attribute :id, String
    attribute :code, String
    attribute :name, String
    attribute :price, Integer
    attribute :unit_price, Integer
    attribute :barcode, String
    attribute :stock, Stock
    attribute :quantity, Integer
  end
end
