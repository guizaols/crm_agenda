require 'spec_helper'

describe "/categorias/index.html.erb" do
  include CategoriasHelper

  before(:each) do
    assigns[:categorias] = [
      stub_model(Categoria,
        :nome => "value for nome",
        :descricao => "value for descricao"
      ),
      stub_model(Categoria,
        :nome => "value for nome",
        :descricao => "value for descricao"
      )
    ]
  end

  it "renders a list of categorias" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
  end
end
