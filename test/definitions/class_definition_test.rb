require File.expand_path("../test_helper", File.dirname(__FILE__))

class ClassDefinitionTest < MiniTest::Unit::TestCase
  def build_class(klass)
    DBR::ClassDefinition.new(klass)
  end

  def setup
  end

  test "name should return fully qualified class name" do
    assert { build_class(MyApp::Employee).name == "MyApp::Employee" }
  end

  test "singleton should return singleton class definition" do
    assert { build_class(MyApp::Employee).singleton.kind_of? DBR::SingletonClassDefinition }
  end

  test "methods should return array of method definitions" do
    assert { build_class(MyApp::Employee).methods.first.kind_of? DBR::MethodDefinition }
  end

  test "methods should return sorted array of method definitions" do
    assert { build_class(MyApp::Simple).methods.map(&:name) == ["a", "b"] }
  end

  test "methods should not include aliases" do
    deny { build_class(MyApp::Employee).methods.map(&:name).include? "wage" }
  end

  test "files should return array of files where class was defined" do
    assert { build_class(MyApp::Employee).files == [File.expand_path("../fixtures/employee.rb", File.dirname(__FILE__))] }
  end

  test "files should return array of files where class without methods was defined" do
    assert { build_class(MyApp::Trivial).files == [] }
  end

  test "constants should return array of constant definitions" do
    assert { build_class(MyApp::Employee).constants.first.kind_of? DBR::ConstantDefinition }
  end

  test "constants should not include class definitions" do
    deny { build_class(MyApp::Employee).constants.map(&:name).include? "Task" }
  end

  test "constants should return empty array if no constants are defined" do
    assert { build_class(MyApp::Simple).constants == [] }
  end
end
