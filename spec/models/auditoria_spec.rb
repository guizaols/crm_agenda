require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Auditoria do
  before(:each) do
    @valid_attributes = {
      :operacao => "value for operacao",
      :usuario_id => 1,
      :proposta_id => 1,
      :historico_id => 1,
      :cliente_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Auditoria.create!(@valid_attributes)
  end
end
