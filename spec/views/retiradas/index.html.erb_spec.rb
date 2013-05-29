require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/retiradas/index.html.erb" do
  include RetiradasHelper

  before(:each) do
    assigns[:retiradas] = [
      stub_model(Retirada,
        :nome => "value for nome",
        :usuario_id => 1,
        :data_entrega => 
      ),
      stub_model(Retirada,
        :nome => "value for nome",
        :usuario_id => 1,
        :data_entrega => 
      )
    ]
  end

  it "renders a list of retiradas" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", .to_s, 2)
  end
end
