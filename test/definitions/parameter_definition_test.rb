require File.expand_path("../test_helper", File.dirname(__FILE__))

class MethodDefinitionTest < MiniTest::Unit::TestCase
  def build_param(name, meth, klass = MyApp::Employee)
    DBR::ClassDefinition.new(klass).methods.find { |method|
      method.name.to_sym == meth
    }.parameters.find { |param|
      param.name.to_sym == name
    }
  end

  def setup
  end

  test "name should return parameter name" do
    assert { build_param(:name, :initialize).name == "name" }
  end

  test "name should return parameter name for splat parameter" do
    assert { build_param(:args, :work).name == "args" }
  end

  test "optional should return false if parameter is required" do
    assert { build_param(:name, :initialize).optional? == false }
  end

  test "optional should return true if parameter is optional" do
    assert { build_param(:currency, :salary).optional? == true }
  end

  test "optional should return false for splat parameter" do
    assert { build_param(:args, :work).optional? == false }
  end

  test "splat should return false if parameter is required" do
    assert { build_param(:name, :initialize).splat? == false }
  end

  test "splat should return false if parameter is optional" do
    assert { build_param(:currency, :salary).splat? == false }
  end

  test "splat should return true for splat parameter" do
    assert { build_param(:args, :work).splat? == true }
  end
end
