require 'spec_helper'

describe "/moedas/edit.html.erb" do
  include MoedasHelper

  before(:each) do
    assigns[:moeda] = @moeda = stub_model(Moeda,
      :new_record? => false,
      :nome => "value for nome",
      :valor => 1.5
    )
  end

  it "renders the edit moeda form" do
    render

    response.should have_tag("form[action=#{moeda_path(@moeda)}][method=post]") do
      with_tag('input#moeda_nome[name=?]', "moeda[nome]")
      with_tag('input#moeda_valor[name=?]', "moeda[valor]")
    end
  end
end
