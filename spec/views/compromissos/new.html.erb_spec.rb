require 'spec_helper'

describe "/compromissos/new.html.erb" do
  include CompromissosHelper

  before(:each) do
    assigns[:compromisso] = stub_model(Compromisso,
      :new_record? => true,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders new compromisso form" do
    render

    response.should have_tag("form[action=?][method=post]", compromissos_path) do
      with_tag("input#compromisso_nome[name=?]", "compromisso[nome]")
      with_tag("textarea#compromisso_descricao[name=?]", "compromisso[descricao]")
    end
  end
end
