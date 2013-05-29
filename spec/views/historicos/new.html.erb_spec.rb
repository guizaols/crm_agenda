require 'spec_helper'

describe "/historicos/new.html.erb" do
  include HistoricosHelper

  before(:each) do
    assigns[:historico] = stub_model(Historico,
      :new_record? => true,
      :usuario_id => 1,
      :descricao => "value for descricao",
      :pessoa_id => 1,
      :proposta_id => 1
    )
  end

  it "renders new historico form" do
    render

    response.should have_tag("form[action=?][method=post]", historicos_path) do
      with_tag("input#historico_usuario_id[name=?]", "historico[usuario_id]")
      with_tag("textarea#historico_descricao[name=?]", "historico[descricao]")
      with_tag("input#historico_pessoa_id[name=?]", "historico[pessoa_id]")
      with_tag("input#historico_proposta_id[name=?]", "historico[proposta_id]")
    end
  end
end
