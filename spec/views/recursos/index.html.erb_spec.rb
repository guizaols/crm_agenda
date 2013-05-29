require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/recursos/index.html.erb" do
  include RecursosHelper

  before(:each) do
    assigns[:recursos] = [
      stub_model(Recurso,
        :nome => "value for nome",
        :descricao => "value for descricao"
      ),
      stub_model(Recurso,
        :nome => "value for nome",
        :descricao => "value for descricao"
      )
    ]
  end

  it "renders a list of recursos" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
  end
end
