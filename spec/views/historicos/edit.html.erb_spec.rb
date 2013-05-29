require 'spec_helper'

describe "/historicos/edit.html.erb" do
  include HistoricosHelper

  before(:each) do
    assigns[:historico] = @historico = stub_model(Historico,
      :new_record? => false,
      :usuario_id => 1,
      :descricao => "value for descricao",
      :pessoa_id => 1,
      :proposta_id => 1
    )
  end

  it "renders the edit historico form" do
    render

    response.should have_tag("form[action=#{historico_path(@historico)}][method=post]") do
      with_tag('input#historico_usuario_id[name=?]', "historico[usuario_id]")
      with_tag('textarea#historico_descricao[name=?]', "historico[descricao]")
      with_tag('input#historico_pessoa_id[name=?]', "historico[pessoa_id]")
      with_tag('input#historico_proposta_id[name=?]', "historico[proposta_id]")
    end
  end
end
