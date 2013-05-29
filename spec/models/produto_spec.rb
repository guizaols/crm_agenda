require 'spec_helper'

describe Produto do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :descricao => "value for descricao"
    }
  end

  it "should create a new instance given valid attributes" do
    Produto.create!(@valid_attributes)
  end
end
