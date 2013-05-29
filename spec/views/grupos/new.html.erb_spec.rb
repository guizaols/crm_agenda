require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/grupos/new.html.erb" do
  include GruposHelper

  before(:each) do
    assigns[:grupo] = stub_model(Grupo,
      :new_record? => true,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders new grupo form" do
    render

    response.should have_tag("form[action=?][method=post]", grupos_path) do
      with_tag("input#grupo_nome[name=?]", "grupo[nome]")
      with_tag("textarea#grupo_descricao[name=?]", "grupo[descricao]")
    end
  end
end
