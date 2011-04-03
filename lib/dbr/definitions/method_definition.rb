module DBR
  class MethodDefinition < Base
    include Comparable

    attr_reader :visibility

    def initialize(reference, visibility)
      @reference = reference
      @visibility = visibility
      @aliases = []
    end

    def name
      @reference.name.to_s
    end

    def comments
      file.comment line if source?
    end

    def aliases
      @aliases.sort!
    end

    def parameters
      @parameters ||= @reference.parameters.collect do |param|
        ParameterDefinition.new param
      end
    end

    def signature
      parameters.map(&:name) * ", "
    end

    def source?
      @reference.source_location and @reference.source_location[0] != "(eval)"
    end

    def file
      @file ||= FileDefinition.new(@reference.source_location[0]) if source?
    end

    def line
      @reference.source_location[1] if source?
    end

    def <=>(other)
      self.name <=> other.name
    end
  end
end
