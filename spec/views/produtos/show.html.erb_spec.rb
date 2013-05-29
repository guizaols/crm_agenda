require 'spec_helper'

describe "/produtos/show.html.erb" do
  include ProdutosHelper
  before(:each) do
    assigns[:produto] = @produto = stub_model(Produto,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
    response.should have_text(/value\ for\ descricao/)
  end
end
