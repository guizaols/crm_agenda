require 'spec_helper'

describe "/origens/new.html.erb" do
  include OrigensHelper

  before(:each) do
    assigns[:origem] = stub_model(Origem,
      :new_record? => true,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders new origem form" do
    render

    response.should have_tag("form[action=?][method=post]", origens_path) do
      with_tag("input#origem_nome[name=?]", "origem[nome]")
      with_tag("textarea#origem_descricao[name=?]", "origem[descricao]")
    end
  end
end
