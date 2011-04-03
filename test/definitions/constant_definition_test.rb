require File.expand_path("../test_helper", File.dirname(__FILE__))

class ConstantDefinitionTest < MiniTest::Unit::TestCase
  def build_const(name, klass = MyApp::Employee)
    DBR::ClassDefinition.new(klass).constants.find { |const| const.name.to_sym == name }
  end

  def setup
  end

  test "name should return constant name" do
    assert { build_const(:TITLES).name == "TITLES" }
  end

  test "value should return constant value" do
    assert { build_const(:TITLES).value == ["Engineer", "Manager"] }
  end
end
