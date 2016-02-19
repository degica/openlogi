require "openlogi/base_object"
require "openlogi/item"

module Openlogi
  class Warehousing < BaseObject
    attribute :id, String
    attribute :items, Array[Item]
    attribute :tracking_codes, Array[String]
    attribute :memo, String
    attribute :status, String
  end
end
