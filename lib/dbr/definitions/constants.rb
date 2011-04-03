module DBR
  module Constants
    def constants
      reference.constants.collect do |constant|
        value = reference.const_get(constant)
        ConstantDefinition.new constant, value unless value.kind_of? Module
      end.compact
    end
  end
end
