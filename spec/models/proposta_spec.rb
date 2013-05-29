require 'spec_helper'

describe Proposta do
  before(:each) do
    @valid_attributes = {
      :pessoa_id => 1,
      :produto_id => 1,
      :status => 1,
      :valor => "value for valor"
    }
  end

  it "should create a new instance given valid attributes" do
    Proposta.create!(@valid_attributes)
  end
end
