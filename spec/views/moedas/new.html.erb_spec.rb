require 'spec_helper'

describe "/moedas/new.html.erb" do
  include MoedasHelper

  before(:each) do
    assigns[:moeda] = stub_model(Moeda,
      :new_record? => true,
      :nome => "value for nome",
      :valor => 1.5
    )
  end

  it "renders new moeda form" do
    render

    response.should have_tag("form[action=?][method=post]", moedas_path) do
      with_tag("input#moeda_nome[name=?]", "moeda[nome]")
      with_tag("input#moeda_valor[name=?]", "moeda[valor]")
    end
  end
end
