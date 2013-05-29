require 'spec_helper'

describe "/acompanhamentos/show.html.erb" do
  include AcompanhamentosHelper
  before(:each) do
    assigns[:acompanhamento] = @acompanhamento = stub_model(Acompanhamento,
      :nome => "value for nome",
      :vendido => 1,
      :descricao => "value for descricao"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ descricao/)
  end
end
