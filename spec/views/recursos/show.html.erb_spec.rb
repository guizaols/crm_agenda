require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/recursos/show.html.erb" do
  include RecursosHelper
  before(:each) do
    assigns[:recurso] = @recurso = stub_model(Recurso,
      :nome => "value for nome",
      :descricao => "value for descricao"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
    response.should have_text(/value\ for\ descricao/)
  end
end
