require 'spec_helper'

describe "/moedas/index.html.erb" do
  include MoedasHelper

  before(:each) do
    assigns[:moedas] = [
      stub_model(Moeda,
        :nome => "value for nome",
        :valor => 1.5
      ),
      stub_model(Moeda,
        :nome => "value for nome",
        :valor => 1.5
      )
    ]
  end

  it "renders a list of moedas" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
  end
end
