require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/retiradas/edit.html.erb" do
  include RetiradasHelper

  before(:each) do
    assigns[:retirada] = @retirada = stub_model(Retirada,
      :new_record? => false,
      :nome => "value for nome",
      :usuario_id => 1,
      :data_entrega => 
    )
  end

  it "renders the edit retirada form" do
    render

    response.should have_tag("form[action=#{retirada_path(@retirada)}][method=post]") do
      with_tag('input#retirada_nome[name=?]', "retirada[nome]")
      with_tag('input#retirada_usuario_id[name=?]', "retirada[usuario_id]")
      with_tag('input#retirada_data_entrega[name=?]', "retirada[data_entrega]")
    end
  end
end
