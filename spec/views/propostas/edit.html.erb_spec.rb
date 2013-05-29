require 'spec_helper'

describe "/propostas/edit.html.erb" do
  include PropostasHelper

  before(:each) do
    assigns[:proposta] = @proposta = stub_model(Proposta,
      :new_record? => false,
      :pessoa_id => 1,
      :produto_id => 1,
      :status => 1,
      :valor => "value for valor"
    )
  end

  it "renders the edit proposta form" do
    render

    response.should have_tag("form[action=#{proposta_path(@proposta)}][method=post]") do
      with_tag('input#proposta_pessoa_id[name=?]', "proposta[pessoa_id]")
      with_tag('input#proposta_produto_id[name=?]', "proposta[produto_id]")
      with_tag('input#proposta_status[name=?]', "proposta[status]")
      with_tag('input#proposta_valor[name=?]', "proposta[valor]")
    end
  end
end
