require 'spec_helper'

describe "/acompanhamentos/edit.html.erb" do
  include AcompanhamentosHelper

  before(:each) do
    assigns[:acompanhamento] = @acompanhamento = stub_model(Acompanhamento,
      :new_record? => false,
      :nome => "value for nome",
      :vendido => 1,
      :descricao => "value for descricao"
    )
  end

  it "renders the edit acompanhamento form" do
    render

    response.should have_tag("form[action=#{acompanhamento_path(@acompanhamento)}][method=post]") do
      with_tag('input#acompanhamento_nome[name=?]', "acompanhamento[nome]")
      with_tag('input#acompanhamento_vendido[name=?]', "acompanhamento[vendido]")
      with_tag('textarea#acompanhamento_descricao[name=?]', "acompanhamento[descricao]")
    end
  end
end
