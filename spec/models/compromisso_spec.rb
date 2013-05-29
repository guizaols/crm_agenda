require 'spec_helper'

describe Compromisso do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :data => Date.today,
      :descricao => "value for descricao"
    }
  end

  it "should create a new instance given valid attributes" do
    Compromisso.create!(@valid_attributes)
  end
end
