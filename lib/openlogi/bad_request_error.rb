module Openlogi
  class BadRequestError < Exception
    def initialize(response)
      super(response.error_description)
    end
  end
end
