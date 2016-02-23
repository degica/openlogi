module Openlogi
  class Boolean
    def self.coerce(v)
      case v
      when String
        !!(v =~ /^(true|t|yes|y|1)$/i)
      when Numeric
        !v.to_i.zero?
      else
        v == true
      end
    end
  end
end
