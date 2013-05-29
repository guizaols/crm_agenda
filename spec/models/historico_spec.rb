require 'spec_helper'

describe Historico do
  before(:each) do
    @valid_attributes = {
      :usuario_id => 1,
      :descricao => "value for descricao",
      :pessoa_id => 1,
      :data => Date.today,
      :proposta_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Historico.create!(@valid_attributes)
  end
end
