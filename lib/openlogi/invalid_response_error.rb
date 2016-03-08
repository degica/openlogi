module Openlogi
  class InvalidResponseError < Exception
    def initialize(response)
      super(response.error_description)
    end
  end
end
