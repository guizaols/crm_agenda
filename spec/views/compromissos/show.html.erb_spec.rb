require 'spec_helper'

describe "/compromissos/show.html.erb" do
  include CompromissosHelper
  before(:each) do
    assigns[:compromisso] = @compromisso = stub_model(Compromisso,
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
