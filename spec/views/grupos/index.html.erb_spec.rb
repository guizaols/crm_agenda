require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/grupos/index.html.erb" do
  include GruposHelper

  before(:each) do
    assigns[:grupos] = [
      stub_model(Grupo,
        :nome => "value for nome",
        :descricao => "value for descricao"
      ),
      stub_model(Grupo,
        :nome => "value for nome",
        :descricao => "value for descricao"
      )
    ]
  end

  it "renders a list of grupos" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
  end
end
