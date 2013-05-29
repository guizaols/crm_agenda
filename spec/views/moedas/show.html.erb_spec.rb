require 'spec_helper'

describe "/moedas/show.html.erb" do
  include MoedasHelper
  before(:each) do
    assigns[:moeda] = @moeda = stub_model(Moeda,
      :nome => "value for nome",
      :valor => 1.5
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
    response.should have_text(/1\.5/)
  end
end
