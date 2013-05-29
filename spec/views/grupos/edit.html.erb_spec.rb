require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/grupos/edit.html.erb" do
  include GruposHelper

  before(:each) do
    assigns[:grupo] = @grupo = stub_model(Grupo,
      :new_record? => false,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders the edit grupo form" do
    render

    response.should have_tag("form[action=#{grupo_path(@grupo)}][method=post]") do
      with_tag('input#grupo_nome[name=?]', "grupo[nome]")
      with_tag('textarea#grupo_descricao[name=?]', "grupo[descricao]")
    end
  end
end
