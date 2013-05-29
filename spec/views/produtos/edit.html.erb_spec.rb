require 'spec_helper'

describe "/produtos/edit.html.erb" do
  include ProdutosHelper

  before(:each) do
    assigns[:produto] = @produto = stub_model(Produto,
      :new_record? => false,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders the edit produto form" do
    render

    response.should have_tag("form[action=#{produto_path(@produto)}][method=post]") do
      with_tag('input#produto_nome[name=?]', "produto[nome]")
      with_tag('textarea#produto_descricao[name=?]', "produto[descricao]")
    end
  end
end
