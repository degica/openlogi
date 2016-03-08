module Openlogi
  class Error < Exception
    def initialize(response)
      super(response.error_description)
    end
  end
end
