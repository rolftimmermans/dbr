$: << File.expand_path("../lib", File.dirname(__FILE__))
require "dbr"

require "minitest/autorun"
require "wrong/adapters/minitest"

require File.expand_path("fixtures/employee", File.dirname(__FILE__))
require File.expand_path("fixtures/simple", File.dirname(__FILE__))
require File.expand_path("fixtures/trivial", File.dirname(__FILE__))

class MiniTest::Unit::TestCase
  class << self
    # Support declarative specification of test methods.
    def test(name)
      define_method "test_#{name.gsub(/\s+/,'_')}".to_sym, &Proc.new
    end
  end
end
