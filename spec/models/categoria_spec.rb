require 'spec_helper'

describe Categoria do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :descricao => "value for descricao"
    }
  end

  it "should create a new instance given valid attributes" do
    Categoria.create!(@valid_attributes)
  end
end
