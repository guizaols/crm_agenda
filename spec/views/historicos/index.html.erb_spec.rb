require 'spec_helper'

describe "/historicos/index.html.erb" do
  include HistoricosHelper

  before(:each) do
    assigns[:historicos] = [
      stub_model(Historico,
        :usuario_id => 1,
        :descricao => "value for descricao",
        :pessoa_id => 1,
        :proposta_id => 1
      ),
      stub_model(Historico,
        :usuario_id => 1,
        :descricao => "value for descricao",
        :pessoa_id => 1,
        :proposta_id => 1
      )
    ]
  end

  it "renders a list of historicos" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
