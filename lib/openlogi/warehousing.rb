require "openlogi/base_object"
require "openlogi/item"

module Openlogi
  class Warehousing < BaseObject
    attribute :id, String
    attribute :items, Array[Openlogi::Item]
    attribute :tracking_codes, Array[String]
    attribute :memo, String
    attribute :status, String
    attribute :created_at, DateTime
  end
end
