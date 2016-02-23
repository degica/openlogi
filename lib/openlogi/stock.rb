require "openlogi/base_object"
require "openlogi/enum"

module Openlogi
  class Stock < BaseObject
    property :available, coerce: Integer
    property :shipping, coerce: Integer
    property :quantity, coerce: Integer
    property :size, coerce: Enum[:SS, :S, :M, :L, :LL, :'3L']
    property :weight, coerce: Integer
  end
end
