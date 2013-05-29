require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Retirada do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :usuario_id => 1,
      :data_retirada => Date.today,
      :data_entrega => 
    }
  end

  it "should create a new instance given valid attributes" do
    Retirada.create!(@valid_attributes)
  end
end
