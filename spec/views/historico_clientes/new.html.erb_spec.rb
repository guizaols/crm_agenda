require 'spec_helper'

describe "/historico_clientes/new.html.erb" do
  include HistoricoClientesHelper

  before(:each) do
    assigns[:historico_cliente] = stub_model(HistoricoCliente,
      :new_record? => true,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders new historico_cliente form" do
    render

    response.should have_tag("form[action=?][method=post]", historico_clientes_path) do
      with_tag("input#historico_cliente_nome[name=?]", "historico_cliente[nome]")
      with_tag("textarea#historico_cliente_descricao[name=?]", "historico_cliente[descricao]")
    end
  end
end
