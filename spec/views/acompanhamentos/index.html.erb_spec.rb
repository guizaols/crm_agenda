require 'spec_helper'

describe "/acompanhamentos/index.html.erb" do
  include AcompanhamentosHelper

  before(:each) do
    assigns[:acompanhamentos] = [
      stub_model(Acompanhamento,
        :nome => "value for nome",
        :vendido => 1,
        :descricao => "value for descricao"
      ),
      stub_model(Acompanhamento,
        :nome => "value for nome",
        :vendido => 1,
        :descricao => "value for descricao"
      )
    ]
  end

  it "renders a list of acompanhamentos" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
  end
end
