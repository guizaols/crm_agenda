require 'spec_helper'

describe "/categorias/show.html.erb" do
  include CategoriasHelper
  before(:each) do
    assigns[:categoria] = @categoria = stub_model(Categoria,
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
