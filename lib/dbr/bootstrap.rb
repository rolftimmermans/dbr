module DBR
  class << self
    def hook!
      @inherited = Class.instance_method(:inherited)

      DBR::Context.reset!
      Class.send :define_method, :inherited do |klass|
        DBR::Context.current.push_class klass
      end
    end

    def unhook!
      Class.send :define_method, :inherited, @inherited
    end

    def document
      hook!
      yield
      unhook!
      generate
    end

    def generate
      HtmlGenerator.new(DBR::Context.current).generate
    end
  end
end
