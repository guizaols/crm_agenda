require 'spec_helper'

describe Mailer do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Mailer.create!(@valid_attributes)
  end
end
