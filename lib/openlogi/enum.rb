require "openlogi/base_object"

module Openlogi
  class Enum
    def self.[](*values)
      Class.new(self).tap { |klass| klass.instance_variable_set(:@values, values) }
    end

    def self.coerce(v)
      @values.include?(v.to_sym) ? v.to_sym : nil
    end
  end
end
