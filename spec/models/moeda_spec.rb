require 'spec_helper'

describe Moeda do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :valor => 1.5
    }
  end

  it "should create a new instance given valid attributes" do
    Moeda.create!(@valid_attributes)
  end
end
