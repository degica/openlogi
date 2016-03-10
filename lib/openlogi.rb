require "openlogi/version"
require "typhoeus"
require "json"
require "hashie"

require "openlogi/configuration"

require "openlogi/api/items"
require "openlogi/api/warehousings"
require "openlogi/api/shipments"

require "openlogi/boolean"
require "openlogi/datetime"
require "openlogi/address"
require "openlogi/stock"
require "openlogi/international_info"
require "openlogi/delivery_options"
require "openlogi/item"
require "openlogi/warehousing"
require "openlogi/shipment"
require "openlogi/request"
require "openlogi/response"
require "openlogi/error"
require "openlogi/bad_request_error"
require "openlogi/internal_server_error"
require "openlogi/client"

module Openlogi
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Openlogi::Configuration.new
    end
  end
end
