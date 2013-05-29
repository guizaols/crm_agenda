require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/recursos/edit.html.erb" do
  include RecursosHelper

  before(:each) do
    assigns[:recurso] = @recurso = stub_model(Recurso,
      :new_record? => false,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders the edit recurso form" do
    render

    response.should have_tag("form[action=#{recurso_path(@recurso)}][method=post]") do
      with_tag('input#recurso_nome[name=?]', "recurso[nome]")
      with_tag('textarea#recurso_descricao[name=?]', "recurso[descricao]")
    end
  end
end
