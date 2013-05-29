require 'spec_helper'

describe "/historicos/show.html.erb" do
  include HistoricosHelper
  before(:each) do
    assigns[:historico] = @historico = stub_model(Historico,
      :usuario_id => 1,
      :descricao => "value for descricao",
      :pessoa_id => 1,
      :proposta_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ descricao/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
