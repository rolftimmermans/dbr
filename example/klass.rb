module Awesome
  class Klass
    class << self
      # Creates a new instance of Klass with the given
      # arguments.
      #
      #     create("name") do |foo|
      #       foo.more
      #     end
      # {:lang="ruby"}
      def create(*args, &block)
        new(*args, &block)
      end

      protected

      # Create Klass from a file.
      def create_from_file
      end
    end

    [:one, :two, :three].each do |method|
      # Counting method.
      define_method method do |foo|
        puts method.to_s
      end
    end

    protected

    # Even *more* awesomeness.
    def more(awesome, options = {})
    end
  end

  Foo = Class.new do
    def one
    end
    alias_method :two, :one
  end

  module Bar
    protected

    def mod_method
    end

    def mod_method_two
    end
  end
end
