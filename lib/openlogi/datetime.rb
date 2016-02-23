module Openlogi
  class DateTime
    def self.coerce(v)
      ::DateTime.parse(v)
    end
  end
end
