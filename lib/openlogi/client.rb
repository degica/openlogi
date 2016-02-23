module Openlogi
  class Client
    attr_reader :access_token, :test_mode
    attr_accessor :last_response

    def initialize(access_token, test_mode: true)
      @access_token = access_token
      @test_mode = test_mode
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
  end
end
