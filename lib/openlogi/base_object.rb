module Openlogi
  class BaseObject
    include Virtus.model

    def initialize(options = {})
      options.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end
  end
end
