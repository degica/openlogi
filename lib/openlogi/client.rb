module Openlogi
  class Client
    attr_accessor :last_response

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Openlogi::Configuration.new
    end

    def test_mode?
      !!test_mode
    end

    def endpoint
      test_mode? ? "https://api-demo.openlogi.com" : "https://api.openlogi.com"
    end

    def items
      @items ||= Api::Items.new(self)
    end

    def warehousings
      @warehousings ||= Api::Warehousings.new(self)
    end

    def shipments
      @shipments ||= Api::Shipments.new(self)
    end

    extend Forwardable
    def_delegators :configuration, :access_token, :test_mode
  end
end
