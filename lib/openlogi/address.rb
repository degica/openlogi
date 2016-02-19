require "openlogi/base_object"

module Openlogi
  class Address < BaseObject
    attribute :postcode, String
    attribute :prefecture, String
    attribute :address1, String
    attribute :address2, String
    attribute :name, String
    attribute :company, String
    attribute :division, String
    attribute :phone, String
  end
end
