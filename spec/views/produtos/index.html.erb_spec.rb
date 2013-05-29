require 'spec_helper'

describe "/produtos/index.html.erb" do
  include ProdutosHelper

  before(:each) do
    assigns[:produtos] = [
      stub_model(Produto,
        :nome => "value for nome",
        :descricao => "value for descricao"
      ),
      stub_model(Produto,
        :nome => "value for nome",
        :descricao => "value for descricao"
      )
    ]
  end

  it "renders a list of produtos" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
  end
end
