class RelatoriosController < ApplicationController

  before_filter :verifica_se_eh_admin, :except => [:aniversarios]
  before_filter :verificar_iphone, :only=>[:funil]
  before_filter :iphone_request?, :only=>[:funil]
  before_filter :mobile_request?, :only=>[:funil]


  def aniversarios
    @pessoas = Pessoa.find(:all, :conditions => ['entidade_id = ? AND
                                                  DAY(data_nascimento) = ? AND
                                                  MONTH(data_nascimento) = ?',
                                                  current_usuario.entidade_id,
                                                  Date.today.day, Date.today.month],
                          :order => 'nome ASC, data_nascimento DESC')
  end


  def prospect
    if current_usuario.perfil_id == 3
      @pessoas = Pessoa.all
    else
      @pessoas = Pessoa.all(:conditions=>["entidade_id = ?",current_usuario.entidade_id])
    end
  end

  def funil
    params[:pesquisa] ||= {}
    unless params[:pesquisa].blank?

      if current_usuario.perfil_id == 3
        if params[:pesquisa][:entidade_id].blank?
          @propostas = Proposta.find(:all,:conditions=>["acompanhamento_id = ?",params[:pesquisa][:status]])
        else
          @propostas = Proposta.find(:all,:include=>[:pessoa],:conditions=>["acompanhamento_id = ? AND pessoas.entidade_id = ?",params[:pesquisa][:status],params[:pesquisa][:entidade_id]])
        end
      else
        @propostas = Proposta.find(:all,:include=>[:usuario],:conditions=>["acompanhamento_id = ? AND usuarios.entidade_id = ?",params[:pesquisa][:status],current_usuario.entidade_id])
      end
    end
  end

  def vendas_por_categoria_de_produto
    params[:pesquisa] ||={}
    @status_venda = Acompanhamento.find_by_vendido(1)
    @data_inicial = params[:pesquisa][:data_inicial].to_date rescue nil
    @data_final = params[:pesquisa][:data_final].to_date rescue nil
  end

  def vendas_por_grupo
    params[:pesquisa] ||= {}
    @status_venda = Acompanhamento.find_by_vendido(1)
    @grupos = Grupo.all
    if !params[:pesquisa][:data_inicial].blank? && !params[:pesquisa][:data_final].blank?

      if current_usuario.perfil_id != 3
        @propostas = Proposta.all(:conditions=>["entidade_id = ? AND acompanhamento_id = ? and data_venda >= ? and data_venda <= ?",current_usuario.entidade_id,@status_venda,params[:pesquisa][:data_inicial].to_date,params[:pesquisa][:data_final].to_date])
      else
        @propostas = Proposta.all(:conditions=>["acompanhamento_id = ? and data_venda >= ? and data_venda <= ?",@status_venda,params[:pesquisa][:data_inicial].to_date,params[:pesquisa][:data_final].to_date])
      end
    else
      if current_usuario.perfil_id != 3
        @propostas = Proposta.all(:conditions=>["entidade_id = ? AND acompanhamento_id = ?",current_usuario.entidade_id,@status_venda])
      else
        @propostas = Proposta.all(:conditions=>["acompanhamento_id = ?",@status_venda])
      end
    end
  end

  def menu

  end

  def espelho
    @compromissos = Compromisso.retorna_para_grafico
    @propostas = Proposta.retorna_propostas_para_grafico
    @funil =  Proposta.retorna_propostas_para_grafico_por_situacao
    @funil_mes = Proposta.retorna_propostas_para_grafico_por_situacao_mes
    @funil_barras = Proposta.retorna_propostas_para_grafico_por_situacao_barras
  end


  def vendas_por_situacao
    params[:pesquisa] ||= {}
    unless params[:pesquisa].blank?
      @propostas = Proposta.procura_propostas(params[:pesquisa],current_usuario)
    end
  end

  def produtividade_funcionarios
    params[:pesquisa] ||= {}
    unless params[:pesquisa].blank?
      @propostas = Proposta.procura_propostas_por_funcionario(params[:pesquisa])
    end
  end

  def auditoria
    params[:pesquisa] ||= {}
    @dados = Auditoria.procura_operacoes(params[:pesquisa],current_usuario)
  end


  def compromissos_funcionarios
    params[:pesquisa] ||= {}
    unless params[:pesquisa].blank?
      @compromissos = Compromisso.procura_compromisso_por_funcionario(params[:pesquisa],current_usuario)
    end
  end


  def funil_iterativo

  end

  def funil_financeiro

  end

  private

  def verifica_se_eh_admin
    if current_usuario.perfil_id == 2
      redirect_to "/"
    end
  end

end
