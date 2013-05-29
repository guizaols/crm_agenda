module ActionView::Helpers::PrototypeHelper::JavaScriptGenerator::GeneratorMethods
  
  def if(condition)
    self << "if (#{condition}) {" 
    yield
    self << "}"
  end
  
  def else
    self << "else {"
    yield
    self << "}"
  end
  
  def function(name, *params)
    self << "function #{name}(#{ params.join ', ' }) {"
    yield
    self << "}"
  end
  
  def var(*names)
    names.collect! {|variable| variable.is_a?(Array) ? "#{variable.first} = #{variable.last}" : variable}
    self << "var #{ names.join ', ' };"
  end
  
end
