require "openlogi/base_object"

module Openlogi
  class Stock < BaseObject
    attribute :available, Integer
    attribute :shipping, Integer
    attribute :quantity, Integer
    attribute :size, String
    attribute :weight, Integer
  end
end
