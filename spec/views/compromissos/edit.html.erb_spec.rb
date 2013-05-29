require 'spec_helper'

describe "/compromissos/edit.html.erb" do
  include CompromissosHelper

  before(:each) do
    assigns[:compromisso] = @compromisso = stub_model(Compromisso,
      :new_record? => false,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders the edit compromisso form" do
    render

    response.should have_tag("form[action=#{compromisso_path(@compromisso)}][method=post]") do
      with_tag('input#compromisso_nome[name=?]', "compromisso[nome]")
      with_tag('textarea#compromisso_descricao[name=?]', "compromisso[descricao]")
    end
  end
end
