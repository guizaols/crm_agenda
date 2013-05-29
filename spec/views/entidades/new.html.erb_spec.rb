require 'spec_helper'

describe "/entidades/new.html.erb" do
  include EntidadesHelper

  before(:each) do
    assigns[:entidade] = stub_model(Entidade,
      :new_record? => true,
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

  it "renders new entidade form" do
    render

    response.should have_tag("form[action=?][method=post]", entidades_path) do
      with_tag("input#entidade_nome[name=?]", "entidade[nome]")
      with_tag("input#entidade_nome_responsavel[name=?]", "entidade[nome_responsavel]")
      with_tag("input#entidade_email_responsavel[name=?]", "entidade[email_responsavel]")
      with_tag("input#entidade_telefone_responsavel[name=?]", "entidade[telefone_responsavel]")
      with_tag("input#entidade_bairro[name=?]", "entidade[bairro]")
      with_tag("input#entidade_numero[name=?]", "entidade[numero]")
      with_tag("input#entidade_cidade[name=?]", "entidade[cidade]")
      with_tag("textarea#entidade_observacoes[name=?]", "entidade[observacoes]")
    end
  end
end
