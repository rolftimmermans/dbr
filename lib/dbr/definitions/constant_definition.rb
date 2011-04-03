module DBR
  class ConstantDefinition < Base
    attr_reader :value

    def initialize(name, value)
      @name, @value = name, value
    end

    def name
      @name.to_s
    end
  end
end
