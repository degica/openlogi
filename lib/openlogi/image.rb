require "openlogi/base_object"
require "openlogi/image_data"

module Openlogi
  class Image < BaseObject
    property :id, coerce: String
    property :content_type, coerce: String
    property :name, coerce: String
    property :url, coerce: String
    property :data, coerce: ImageData
  end
end
