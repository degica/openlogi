module Openlogi
  class Boolean
    def self.coerce(v)
      case v
      when String
        return !!(v =~ /^(true|t|yes|y|1)$/i)
      when Numeric
        return !v.to_i.zero?
      else
        return v == true
      end
    end
  end
end
