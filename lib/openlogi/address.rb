require "openlogi/base_object"

module Openlogi
  class Address < BaseObject
    property :postcode
    property :prefecture
    property :address1
    property :address2
    property :name
    property :company
    property :division
    property :phone
  end
end
