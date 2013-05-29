require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/grupos/show.html.erb" do
  include GruposHelper
  before(:each) do
    assigns[:grupo] = @grupo = stub_model(Grupo,
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
