require 'spec_helper'

describe "/compromissos/index.html.erb" do
  include CompromissosHelper

  before(:each) do
    assigns[:compromissos] = [
      stub_model(Compromisso,
        :nome => "value for nome",
        :descricao => "value for descricao"
      ),
      stub_model(Compromisso,
        :nome => "value for nome",
        :descricao => "value for descricao"
      )
    ]
  end

  it "renders a list of compromissos" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
  end
end
