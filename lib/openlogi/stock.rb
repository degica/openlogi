require "openlogi/base_object"

module Openlogi
  class Stock < BaseObject
    property :available, coerce: Integer
    property :shipping, coerce: Integer
    property :quantity, coerce: Integer
    property :size, coerce: String
    property :weight, coerce: Integer
  end
end
