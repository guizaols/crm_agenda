require 'spec_helper'

describe Acompanhamento do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :vendido => 1,
      :descricao => "value for descricao"
    }
  end

  it "should create a new instance given valid attributes" do
    Acompanhamento.create!(@valid_attributes)
  end
end
