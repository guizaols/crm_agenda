require 'spec_helper'

describe "/tipo_compromissos/edit.html.erb" do
  include TipoCompromissosHelper

  before(:each) do
    assigns[:tipo_compromisso] = @tipo_compromisso = stub_model(TipoCompromisso,
      :new_record? => false,
      :nome => "value for nome"
    )
  end

  it "renders the edit tipo_compromisso form" do
    render

    response.should have_tag("form[action=#{tipo_compromisso_path(@tipo_compromisso)}][method=post]") do
      with_tag('input#tipo_compromisso_nome[name=?]', "tipo_compromisso[nome]")
    end
  end
end
