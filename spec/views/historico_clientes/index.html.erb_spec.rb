require 'spec_helper'

describe "/historico_clientes/index.html.erb" do
  include HistoricoClientesHelper

  before(:each) do
    assigns[:historico_clientes] = [
      stub_model(HistoricoCliente,
        :nome => "value for nome",
        :descricao => "value for descricao"
      ),
      stub_model(HistoricoCliente,
        :nome => "value for nome",
        :descricao => "value for descricao"
      )
    ]
  end

  it "renders a list of historico_clientes" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
  end
end
