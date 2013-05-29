require 'spec_helper'

describe "/entidades/index.html.erb" do
  include EntidadesHelper

  before(:each) do
    assigns[:entidades] = [
      stub_model(Entidade,
        :nome => "value for nome",
        :nome_responsavel => "value for nome_responsavel",
        :email_responsavel => "value for email_responsavel",
        :telefone_responsavel => "value for telefone_responsavel",
        :bairro => "value for bairro",
        :numero => "value for numero",
        :cidade => "value for cidade",
        :observacoes => "value for observacoes"
      ),
      stub_model(Entidade,
        :nome => "value for nome",
        :nome_responsavel => "value for nome_responsavel",
        :email_responsavel => "value for email_responsavel",
        :telefone_responsavel => "value for telefone_responsavel",
        :bairro => "value for bairro",
        :numero => "value for numero",
        :cidade => "value for cidade",
        :observacoes => "value for observacoes"
      )
    ]
  end

  it "renders a list of entidades" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", "value for nome_responsavel".to_s, 2)
    response.should have_tag("tr>td", "value for email_responsavel".to_s, 2)
    response.should have_tag("tr>td", "value for telefone_responsavel".to_s, 2)
    response.should have_tag("tr>td", "value for bairro".to_s, 2)
    response.should have_tag("tr>td", "value for numero".to_s, 2)
    response.should have_tag("tr>td", "value for cidade".to_s, 2)
    response.should have_tag("tr>td", "value for observacoes".to_s, 2)
  end
end
