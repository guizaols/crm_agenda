require 'spec_helper'

describe "/propostas/new.html.erb" do
  include PropostasHelper

  before(:each) do
    assigns[:proposta] = stub_model(Proposta,
      :new_record? => true,
      :pessoa_id => 1,
      :produto_id => 1,
      :status => 1,
      :valor => "value for valor"
    )
  end

  it "renders new proposta form" do
    render

    response.should have_tag("form[action=?][method=post]", propostas_path) do
      with_tag("input#proposta_pessoa_id[name=?]", "proposta[pessoa_id]")
      with_tag("input#proposta_produto_id[name=?]", "proposta[produto_id]")
      with_tag("input#proposta_status[name=?]", "proposta[status]")
      with_tag("input#proposta_valor[name=?]", "proposta[valor]")
    end
  end
end
