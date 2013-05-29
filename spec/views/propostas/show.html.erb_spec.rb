require 'spec_helper'

describe "/propostas/show.html.erb" do
  include PropostasHelper
  before(:each) do
    assigns[:proposta] = @proposta = stub_model(Proposta,
      :pessoa_id => 1,
      :produto_id => 1,
      :status => 1,
      :valor => "value for valor"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ valor/)
  end
end
