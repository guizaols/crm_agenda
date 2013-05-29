require 'spec_helper'

describe Suporte do
  before(:each) do
    @valid_attributes = {
      :proposta_id => 1,
      :data => Date.today,
      :prioridade => 1,
      :status => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Suporte.create!(@valid_attributes)
  end
end
