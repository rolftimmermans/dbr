module DBR
  class ClassDefinition < Base
    include Methods
    include Constants

    attr_reader :reference

    def initialize(reference)
      @reference = reference
    end

    def name
      @reference.name
    end
    alias_method :inspect, :name

    def singleton
      SingletonClassDefinition.new self, @reference.singleton_class
    end
  end
end
