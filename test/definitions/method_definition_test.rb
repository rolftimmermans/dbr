require File.expand_path("../test_helper", File.dirname(__FILE__))

class MethodDefinitionTest < MiniTest::Unit::TestCase
  def build_method(name, klass = MyApp::Employee)
    DBR::ClassDefinition.new(klass).methods.find { |method| method.name.to_sym == name }
  end

  def setup
  end

  test "name should return method name" do
    assert { build_method(:salary).name == "salary" }
  end
  
  test "comments should return comments for method" do
    assert { build_method(:salary).comments == "The salary that is paid to an employee." }
  end

  test "parameters should return array of paramter definitions" do
    assert { build_method(:salary).parameters.first.kind_of? DBR::ParameterDefinition }
  end

  test "aliases should return empty array when method is not aliased" do
    assert { build_method(:name).aliases == [] }
  end

  test "aliases should return array of names when method is aliased" do
    assert { build_method(:salary).aliases == ["payment", "wage"] }
  end

  test "visibility should return public for public method" do
    assert { build_method(:salary).visibility == :public }
  end

  test "visibility should return protected for protected method" do
    assert { build_method(:start_work).visibility == :protected }
  end

  test "visibility should return private for private method" do
    assert { build_method(:task_one).visibility == :private }
  end

  test "file should return file name where method was defined" do
    assert { build_method(:salary).file =~ %r{fixtures/employee.rb} }
  end

  test "line should return line number where method was defined" do
    assert { build_method(:initialize).line == 3 }
  end
end
