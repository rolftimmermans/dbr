module DBR
  class Base
    def type
      self.class.name.sub(/.*::(\w+)Definition/, "\\1").downcase
    end
  end
end
