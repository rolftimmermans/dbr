module DBR
  class Context
    class << self
      attr_accessor :current

      def reset!
        self.current = new
      end
    end

    attr_reader :classes

    def initialize
      @classes = []
    end

    def push_class(class_reference)
      @classes << ClassDefinition.new(class_reference)
    end
  end
end
