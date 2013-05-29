require 'spec_helper'

describe "/entidades/show.html.erb" do
  include EntidadesHelper
  before(:each) do
    assigns[:entidade] = @entidade = stub_model(Entidade,
      :nome => "value for nome",
      :nome_responsavel => "value for nome_responsavel",
      :email_responsavel => "value for email_responsavel",
      :telefone_responsavel => "value for telefone_responsavel",
      :bairro => "value for bairro",
      :numero => "value for numero",
      :cidade => "value for cidade",
      :observacoes => "value for observacoes"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
    response.should have_text(/value\ for\ nome_responsavel/)
    response.should have_text(/value\ for\ email_responsavel/)
    response.should have_text(/value\ for\ telefone_responsavel/)
    response.should have_text(/value\ for\ bairro/)
    response.should have_text(/value\ for\ numero/)
    response.should have_text(/value\ for\ cidade/)
    response.should have_text(/value\ for\ observacoes/)
  end
end
