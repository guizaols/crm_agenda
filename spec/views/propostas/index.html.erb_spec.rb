require 'spec_helper'

describe "/propostas/index.html.erb" do
  include PropostasHelper

  before(:each) do
    assigns[:propostas] = [
      stub_model(Proposta,
        :pessoa_id => 1,
        :produto_id => 1,
        :status => 1,
        :valor => "value for valor"
      ),
      stub_model(Proposta,
        :pessoa_id => 1,
        :produto_id => 1,
        :status => 1,
        :valor => "value for valor"
      )
    ]
  end

  it "renders a list of propostas" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for valor".to_s, 2)
  end
end
