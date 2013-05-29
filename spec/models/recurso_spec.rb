require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Recurso do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :descricao => "value for descricao"
    }
  end

  it "should create a new instance given valid attributes" do
    Recurso.create!(@valid_attributes)
  end
end
