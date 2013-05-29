require 'spec_helper'

describe "/categorias/edit.html.erb" do
  include CategoriasHelper

  before(:each) do
    assigns[:categoria] = @categoria = stub_model(Categoria,
      :new_record? => false,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders the edit categoria form" do
    render

    response.should have_tag("form[action=#{categoria_path(@categoria)}][method=post]") do
      with_tag('input#categoria_nome[name=?]', "categoria[nome]")
      with_tag('textarea#categoria_descricao[name=?]', "categoria[descricao]")
    end
  end
end
