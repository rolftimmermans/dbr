module DBR
  class SingletonClassDefinition < Base
    include Methods

    attr_reader :reference

    def initialize(class_definition, reference)
      @class_definition = class_definition
      @reference = reference
    end

    def name
      @class_definition.name
    end
  end
end
