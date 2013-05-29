require 'spec_helper'

describe "/tipo_compromissos/index.html.erb" do
  include TipoCompromissosHelper

  before(:each) do
    assigns[:tipo_compromissos] = [
      stub_model(TipoCompromisso,
        :nome => "value for nome"
      ),
      stub_model(TipoCompromisso,
        :nome => "value for nome"
      )
    ]
  end

  it "renders a list of tipo_compromissos" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
  end
end
