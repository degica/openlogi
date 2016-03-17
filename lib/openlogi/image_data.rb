require "openlogi/base_object"
require "openlogi/image_data_details"

module Openlogi
  class ImageData < BaseObject
    property :original, coerce: ImageDataDetails
    property :thumbnail, coerce: ImageDataDetails
    property :icon, coerce: ImageDataDetails
  end
end
