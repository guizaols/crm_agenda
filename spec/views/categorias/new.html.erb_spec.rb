require 'spec_helper'

describe "/categorias/new.html.erb" do
  include CategoriasHelper

  before(:each) do
    assigns[:categoria] = stub_model(Categoria,
      :new_record? => true,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders new categoria form" do
    render

    response.should have_tag("form[action=?][method=post]", categorias_path) do
      with_tag("input#categoria_nome[name=?]", "categoria[nome]")
      with_tag("textarea#categoria_descricao[name=?]", "categoria[descricao]")
    end
  end
end
