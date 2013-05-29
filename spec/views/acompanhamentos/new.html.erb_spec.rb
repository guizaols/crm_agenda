require 'spec_helper'

describe "/acompanhamentos/new.html.erb" do
  include AcompanhamentosHelper

  before(:each) do
    assigns[:acompanhamento] = stub_model(Acompanhamento,
      :new_record? => true,
      :nome => "value for nome",
      :vendido => 1,
      :descricao => "value for descricao"
    )
  end

  it "renders new acompanhamento form" do
    render

    response.should have_tag("form[action=?][method=post]", acompanhamentos_path) do
      with_tag("input#acompanhamento_nome[name=?]", "acompanhamento[nome]")
      with_tag("input#acompanhamento_vendido[name=?]", "acompanhamento[vendido]")
      with_tag("textarea#acompanhamento_descricao[name=?]", "acompanhamento[descricao]")
    end
  end
end
