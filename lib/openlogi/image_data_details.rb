require "openlogi/base_object"

module Openlogi
  class ImageDataDetails < BaseObject
    property :height, coerce: Integer
    property :width, coerce: Integer
    property :url, coerce: String
  end
end
