require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/retiradas/new.html.erb" do
  include RetiradasHelper

  before(:each) do
    assigns[:retirada] = stub_model(Retirada,
      :new_record? => true,
      :nome => "value for nome",
      :usuario_id => 1,
      :data_entrega => 
    )
  end

  it "renders new retirada form" do
    render

    response.should have_tag("form[action=?][method=post]", retiradas_path) do
      with_tag("input#retirada_nome[name=?]", "retirada[nome]")
      with_tag("input#retirada_usuario_id[name=?]", "retirada[usuario_id]")
      with_tag("input#retirada_data_entrega[name=?]", "retirada[data_entrega]")
    end
  end
end
