require 'spec_helper'

describe "/tipo_compromissos/show.html.erb" do
  include TipoCompromissosHelper
  before(:each) do
    assigns[:tipo_compromisso] = @tipo_compromisso = stub_model(TipoCompromisso,
      :nome => "value for nome"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
  end
end
