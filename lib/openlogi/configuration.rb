module Openlogi
  class Configuration
    attr_accessor :access_token, :test_mode

    def initialize
      @test_mode = true
    end
  end
end
