require 'spec_helper'

describe Entidade do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :nome_responsavel => "value for nome_responsavel",
      :email_responsavel => "value for email_responsavel",
      :telefone_responsavel => "value for telefone_responsavel",
      :bairro => "value for bairro",
      :numero => "value for numero",
      :cidade => "value for cidade",
      :observacoes => "value for observacoes"
    }
  end

  it "should create a new instance given valid attributes" do
    Entidade.create!(@valid_attributes)
  end
end
