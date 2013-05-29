require 'spec_helper'

describe "/historico_clientes/show.html.erb" do
  include HistoricoClientesHelper
  before(:each) do
    assigns[:historico_cliente] = @historico_cliente = stub_model(HistoricoCliente,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
    response.should have_text(/value\ for\ descricao/)
  end
end
