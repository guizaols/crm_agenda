require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/recursos/new.html.erb" do
  include RecursosHelper

  before(:each) do
    assigns[:recurso] = stub_model(Recurso,
      :new_record? => true,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders new recurso form" do
    render

    response.should have_tag("form[action=?][method=post]", recursos_path) do
      with_tag("input#recurso_nome[name=?]", "recurso[nome]")
      with_tag("textarea#recurso_descricao[name=?]", "recurso[descricao]")
    end
  end
end
