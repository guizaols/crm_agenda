require 'spec_helper'

describe "/tipo_compromissos/new.html.erb" do
  include TipoCompromissosHelper

  before(:each) do
    assigns[:tipo_compromisso] = stub_model(TipoCompromisso,
      :new_record? => true,
      :nome => "value for nome"
    )
  end

  it "renders new tipo_compromisso form" do
    render

    response.should have_tag("form[action=?][method=post]", tipo_compromissos_path) do
      with_tag("input#tipo_compromisso_nome[name=?]", "tipo_compromisso[nome]")
    end
  end
end
