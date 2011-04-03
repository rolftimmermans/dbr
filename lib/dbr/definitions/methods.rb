module DBR
  module Methods
    def methods
      (public_methods + protected_methods + private_methods).sort
    end

    def public_methods
      find_methods :public
    end

    def protected_methods
      find_methods :protected
    end

    def private_methods
      find_methods :private
    end

    def files
      methods.map(&:file).uniq
    end

    private

    def find_methods(visibility)
      aliases = {}
      {}.tap do |methods|
        reference.send(:"#{visibility}_instance_methods", false).each do |name|
          name = name.to_s
          method = reference.instance_method(name)
          if name == (original_name = method.inspect.sub(%r{.*#(\w+[=?!]?)>$}, "\\1"))
            methods[name] = MethodDefinition.new(method, visibility)
          else
            aliases[name] = original_name
          end
        end

        # aliases.each do |aliased, original|
        #   methods[original].aliases << aliased
        # end
      end.values.sort
    end
  end
end
