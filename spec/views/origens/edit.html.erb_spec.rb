require 'spec_helper'

describe "/origens/edit.html.erb" do
  include OrigensHelper

  before(:each) do
    assigns[:origem] = @origem = stub_model(Origem,
      :new_record? => false,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders the edit origem form" do
    render

    response.should have_tag("form[action=#{origem_path(@origem)}][method=post]") do
      with_tag('input#origem_nome[name=?]', "origem[nome]")
      with_tag('textarea#origem_descricao[name=?]', "origem[descricao]")
    end
  end
end
