class MinhaEmpresaController < ApplicationController

 before_filter :verificar_iphone
  before_filter :iphone_request?
  before_filter :mobile_request?
 

  def show
    @compromissos = Compromisso.retorna_para_grafico(current_usuario)


    @propostas = Proposta.retorna_propostas_para_grafico(current_usuario)


    @funil =  Proposta.retorna_propostas_para_grafico_por_situacao(current_usuario)


    @funil_mes = Proposta.retorna_propostas_para_grafico_por_situacao_mes(current_usuario)


    @funil_barras = Proposta.retorna_propostas_para_grafico_por_situacao_barras(current_usuario)
  end
end
