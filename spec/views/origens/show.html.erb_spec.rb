require 'spec_helper'

describe "/origens/show.html.erb" do
  include OrigensHelper
  before(:each) do
    assigns[:origem] = @origem = stub_model(Origem,
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
