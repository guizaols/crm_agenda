require 'spec_helper'

describe Pessoa do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Pessoa.create!(@valid_attributes)
  end
end
