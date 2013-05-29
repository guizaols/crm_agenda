require 'rubygems'
require 'test/unit'
require 'action_controller'
require 'action_view/test_case'
require File.join(File.dirname(__FILE__), '../init')

class JSGenerator
  include ActionView::Helpers::PrototypeHelper
end

class JavascriptHelperInovareTest < ActionView::TestCase
  
  def setup
    @generator = JSGenerator.new
  end
  
  def teardown
    validate_generated_javascript
  end
  
  def test_empty_if_condition
    @block = Proc.new do |page|
      page.if 'true' do
      end
    end
    
    @expected_js = <<-JAVASCRIPT
if (true) {
}
JAVASCRIPT
  end
  
  def test_basic_if_condition
    @block = Proc.new do |page|
      page.if 'false' do
        page.alert 'Something is wrong'
      end
    end
    
    @expected_js = <<-JAVASCRIPT
if (false) {
alert("Something is wrong");
}
JAVASCRIPT
  end
  
  def test_if_else_condition
    @block = Proc.new do |page|
      page.if 'true' do
        page.alert 'I am OK!'
      end
      page.else do
        page.alert 'I am crazy!'
      end
    end
    @expected_js = <<-JAVASCRIPT
if (true) {
alert("I am OK!");
}
else {
alert("I am crazy!");
}
JAVASCRIPT
  end
  
  def test_empty_function
    @block = Proc.new do |page|
      page.function :do_nothing do
        
      end
    end
    
    @expected_js = <<-JAVASCRIPT
function do_nothing() {
}
JAVASCRIPT
  end
  
  def test_annoying_function
    @block = Proc.new do |page|
      page.function :call_for_attention do
        page.alert 'Hi!'
      end
    end
    
    @expected_js = <<-JAVASCRIPT
function call_for_attention() {
alert("Hi!");
}
JAVASCRIPT
  end
  
  def test_function_with_parameters
    @block = Proc.new do |page|
      page.function 'sum', 'first', 'second' do
        page << 'return (first + second);'
      end
    end
    
    @expected_js = <<-JAVASCRIPT
function sum(first, second) {
return (first + second);
}
JAVASCRIPT
  end
  
  def test_declare_variable
    @block = Proc.new do |page|
      page.var 'useless_variable'
    end
    
    @expected_js = 'var useless_variable;'
  end
  
  def test_declare_many_variables
    @block = Proc.new do |page|
      page.var 'useless_variable', 'even_more_useless'
    end
    
    @expected_js = 'var useless_variable, even_more_useless;'
  end

  def test_declare_variables_with_default_values
    @block = Proc.new do |page|
      page.var ['true_value', 'true'], 'no_default_value'
    end
    
    @expected_js = 'var true_value = true, no_default_value;'
  end
private
  
  def validate_generated_javascript
    assert_equal @expected_js.chomp, @generator.update_page(&@block)
  end
end
