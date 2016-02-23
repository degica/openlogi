module Openlogi
  class Boolean
    def self.coerce(v)
      case v
      when String
        !!(v =~ /\A(true|t|yes|y|1)\z/i)
      when Numeric
        !v.to_i.zero?
      else
        v == true
      end
    end
  end
end
