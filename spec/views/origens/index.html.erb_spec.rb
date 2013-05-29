require 'spec_helper'

describe "/origens/index.html.erb" do
  include OrigensHelper

  before(:each) do
    assigns[:origens] = [
      stub_model(Origem,
        :nome => "value for nome",
        :descricao => "value for descricao"
      ),
      stub_model(Origem,
        :nome => "value for nome",
        :descricao => "value for descricao"
      )
    ]
  end

  it "renders a list of origens" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
  end
end
