require "openlogi/base_object"
require "openlogi/item"
require "openlogi/datetime"

module Openlogi
  class Warehousing < BaseObject
    property :id
    property :items, coerce: Array[Item]
    property :tracking_codes, coerce: Array[String]
    property :memo
    property :status
    property :created_at, coerce: DateTime
  end
end
