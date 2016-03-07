module Openlogi
  class ResponseError < Exception
    def initialize(response)
      super(response.error)
    end
  end
end
