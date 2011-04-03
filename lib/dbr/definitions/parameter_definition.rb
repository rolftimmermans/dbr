module DBR
  class ParameterDefinition < Base
    def initialize(reference)
      @type, @name = reference
    end

    def name
      @name.to_s
    end

    def optional?
      @type == :opt
    end

    def splat?
      @type == :rest
    end
  end
end
