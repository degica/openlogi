require "openlogi/base_object"
require "openlogi/enum"

module Openlogi
  class Stock < BaseObject
    property :available, coerce: Integer
    property :shipping, coerce: Integer
    property :quantity, coerce: Integer
    property :size, coerce: Enum[:SS, :S, :M, :L, :LL, :'3L']
    property :weight, coerce: Integer
    property :backordered, coerce: Integer
    property :created_at, coerce: DateTime
    property :updated_at, coerce: DateTime
    property :reserved, coerce: Integer
  end
end
