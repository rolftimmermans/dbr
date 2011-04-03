require File.expand_path("../test_helper", File.dirname(__FILE__))

class SingletonClassDefinitionTest < MiniTest::Unit::TestCase
  def build_class(klass)
    DBR::ClassDefinition.new(klass).singleton
  end

  def setup
  end

  test "name should return fully qualified class name" do
    assert { build_class(MyApp::Employee).name == "MyApp::Employee" }
  end

  test "methods should return array of method definitions" do
    assert { build_class(MyApp::Employee).methods.first.kind_of? DBR::MethodDefinition }
  end

  test "methods should include class methods" do
    assert { build_class(MyApp::Employee).methods.map(&:name).include? "create" }
  end
end
