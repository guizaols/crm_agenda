require 'spec_helper'

describe "/produtos/new.html.erb" do
  include ProdutosHelper

  before(:each) do
    assigns[:produto] = stub_model(Produto,
      :new_record? => true,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders new produto form" do
    render

    response.should have_tag("form[action=?][method=post]", produtos_path) do
      with_tag("input#produto_nome[name=?]", "produto[nome]")
      with_tag("textarea#produto_descricao[name=?]", "produto[descricao]")
    end
  end
end
