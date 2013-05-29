require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/retiradas/show.html.erb" do
  include RetiradasHelper
  before(:each) do
    assigns[:retirada] = @retirada = stub_model(Retirada,
      :nome => "value for nome",
      :usuario_id => 1,
      :data_entrega => 
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
    response.should have_text(/1/)
    response.should have_text(//)
  end
end
