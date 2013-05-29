class PropostasController < ApplicationController

  before_filter :carrega_cliente,:except=>[:calcula_valor_financiamento,:calcula_preco,:grafico_vendas_por_funcionario,:grafico_status,:carrega_preco]

  def index
    @propostas = Proposta.find_all_by_pessoa_id(params[:pessoa_id])
  end

  def calcula_preco
    @produto = Produto.find params[:produto_id]
    preco = @produto.valor.gsub(/[,\.]/, "").to_f/100
    quantidade = params[:quantidade].to_i
    valor_entrada = params[:valor_entrada].gsub(/[,\.]/, "").gsub("R$ ","").to_f/100
    valor_seminovo = params[:valor_seminovo].gsub(/[,\.]/, "").gsub("R$ ","").to_f/100

    @aux = Proposta.new
    @aux.valor = preco*quantidade
    valor= @aux.valor.reais_contabeis.gsub("R$ ","")

    valor_financiamento = Proposta.calcula_financiamento(preco, quantidade, valor_entrada, valor_seminovo)

    render :update do |page|
      page << "$('proposta_valor').value = '#{valor}'"
      if valor_financiamento.gsub("R$ ","").gsub(/[,\.]/, "").to_f/100 > 0
        page << "if($('proposta_veiculo_financiado').checked){"
        page << "$('proposta_valor_financiado').value = '#{valor_financiamento}'"
        page << "}"
      else
        page << "alert('O valor do financiamento não pode ser negativo!')"
      end
    end
  end

  def calcula_valor_financiamento
    render :update do |page|
      page << "if($('proposta_veiculo_financiado').checked){"
      @produto = Produto.find params[:produto_id]
      valor_produto = @produto.valor.gsub(/[,\.]/, "").to_f/100
      quantidade = params[:quantidade].to_i
      valor_entrada = params[:valor_entrada].gsub(/[,\.]/, "").gsub("R$ ","").to_f/100
      valor_seminovo = params[:valor_seminovo].gsub(/[,\.]/, "").gsub("R$ ","").to_f/100
      valor_financiamento = Proposta.calcula_financiamento(valor_produto, quantidade, valor_entrada, valor_seminovo)

      if valor_financiamento.gsub("R$ ","").gsub(/[,\.]/, "").to_f/100 > 0
      page << "$('proposta_valor_financiado').value = '#{valor_financiamento}'"
      else
        page << "alert('O valor do financiamento não pode ser negativo!')"
      end


      page << "}"
    end
  end

  def show
    @proposta = Proposta.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    @historicos = Historico.find(:all,:conditions=>["proposta_id = ?",@proposta.id],:order=>"data DESC")
    @suportes = Suporte.find_all_by_proposta_id(@proposta.id)
  end

  def finalizar_venda
    @proposta = Proposta.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    render :update do |page|
      page << "if (confirm('CUIDADO!!!!OPERAÇÃO DEFINITIVA!!!!A NEGOCIAÇÃO ENCONTRA-SE REALMENTE FINALIZADA???!')){"
      if params[:data_venda].blank?
        page.alert 'Preencha o campo Data da Venda!'
      else
        @proposta.data_venda = params[:data_venda]
        @proposta.status = 4
        @proposta.save!
        page.alert 'Venda concluída com sucesso!'
        page << 'window.location.reload()'
      end
      page << "}"
    end
  end

  def carrega_preco
    render :update do |page|
      @produto = Produto.find params[:produto_id]
      page << "$('proposta_valor').value = '#{@produto.valor}'"
    end
  end

  def grafico_status
    @propostas = Proposta.grafico_vendas_status(params[:status])
    render :update do |page|
      page.replace "status_propostas_barras",:partial=>"relatorios/grafico_barra",:locals=>{:f=>@propostas,:id=>"status_propostas_barras"}
      if params[:status] == "anterior"
        page.replace "label_status",:text=>"<h3 id='label_status'>Status Propostas (#{Compromisso::MES[Date.today.month - 1]})</h3>"
      else
        page.replace "label_status",:text=>"<h3 id='label_status'>Status Propostas (#{Compromisso::MES[Date.today.month]})</h3>"
      end


    end
  end

  def grafico_vendas_por_funcionario
    @propostas = Proposta.grafico_vendas(params[:status])
    render :update do |page|
      page.replace "vendas_por_funcionario",:partial=>"relatorios/grafico_barra",:locals=>{:f=>@propostas,:id=>"vendas_por_funcionario"}
      if params[:status] == "anterior"
        page.replace "label_vendas",:text=>"<h3 id='label_vendas'>Vendas por funcionário (#{Compromisso::MES[Date.today.month - 1]})</h3>"
      else
        page.replace "label_vendas",:text=>"<h3 id='label_vendas'>Vendas por funcionário (#{Compromisso::MES[Date.today.month]})</h3>"
      end
    end
  end
  

  def new
    @proposta = Proposta.new
  end

  def edit
    @proposta = Proposta.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
 
  end

  def destroy
    @proposta = Proposta.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    @proposta.destroy
    flash[:notice] = "Proposta excluída com sucesso!"
    redirect_to pessoa_propostas_path(@pessoa)
  end

  def altera_valor_proposta
    @proposta = Proposta.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    @proposta.valor_virtual = params[:valor_proposta]
    render :update do |page|
      if @proposta.save!
        page.alert 'Valor da proposta atualizado com sucesso!'
        page << "window.location.reload()"
      else
        page.alert 'Não foi possível atualizar o valor da proposta!'
      end
    end

  end
  def altera_status_proposta
    @proposta = Proposta.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    @proposta.valor_virtual = @proposta.valor
    @proposta.acompanhamento_id = params[:status]
    @acompanhamento = Acompanhamento.find params[:status]
    if @acompanhamento.vendido == Acompanhamento::VENDIDO
      @proposta.data_venda = Date.today.to_s_br
    else
      @proposta.data_venda = nil
    end
    render :update do |page|
      Auditoria.create :entidade_id=>current_usuario.entidade_id,:data=>Date.today.to_s_br,:operacao=>"Status da Proposta Avançou",:usuario_id=>current_usuario.id,:pessoa_id=>@pessoa.id,:proposta_id=>@proposta.id
      if @proposta.save!
        page.alert "Status da negociação foi alterado com sucesso!"
        page << "window.location.reload()"
      else
        page.alert 'Não foi possível alterar o status na negociação!'
      end
    end

  end

  def create
    @proposta = Proposta.new(params[:proposta])
    @proposta.pessoa_id = @pessoa.id
    @proposta.usuario_id = current_usuario.id
    @proposta.entidade_id = current_usuario.entidade_id
    unless @proposta.acompanhamento.blank?
      if @proposta.acompanhamento.vendido == 1
        @proposta.data_venda = Date.today.to_s_br
      end
    end

    if @proposta.save
      Auditoria.create :entidade_id=>current_usuario.entidade_id,:data=>Date.today.to_s_br,:operacao=>"Proposta Cadastrada",:usuario_id=>current_usuario.id,:pessoa_id=>@pessoa.id,:proposta_id=>@proposta.id
      flash[:notice] = 'Proposta criada com sucesso!'
      redirect_to pessoa_propostas_path(@pessoa)
    else
      render :action => "new"
    end
  end

  def update
    @proposta = Proposta.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    @proposta.pessoa_id = @pessoa.id
    #@proposta.usuario_id = current_usuario.id
    @proposta.entidade_id = current_usuario.entidade_id
    unless @proposta.acompanhamento.blank?
      if @proposta.acompanhamento.vendido == 1
        @proposta.data_venda = Date.today.to_s_br
      end
    end

    if @proposta.update_attributes(params[:proposta])
      Auditoria.create :entidade_id=>current_usuario.entidade_id,:data=>Date.today.to_s_br,:operacao=>"Proposta Atualizada",:usuario_id=>current_usuario.id,:pessoa_id=>@pessoa.id,:proposta_id=>@proposta.id
      flash[:notice] = 'Proposta atualizada com sucesso!'
      redirect_to pessoa_propostas_path(@pessoa)
    else
      render :action => "edit"
    end
  end

  def solicitar_orcamento
    @proposta = Proposta.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    render :update do |page|
      if Suporte.create! :data=>Date.today,:usuario=>current_usuario,:proposta=>@proposta,:status=>Suporte::STATUS[1]
        Auditoria.create :entidade_id=>current_usuario.entidade_id,:data=>Date.today.to_s_br,:operacao=>"Orçamento Solicitado",:usuario_id=>current_usuario.id,:pessoa_id=>@pessoa.id,:proposta_id=>@proposta.id
        # Mailer.deliver_contato(current_usuario.name, current_usuario.email, "Existe uma nova solicitação de orçamento. Acesse a ferramenta de vendas!")
        page.alert "Solicitação de Orçamento foi realizada!"
        page << "window.location.reload()"
      end
    end
  end

  private

  def carrega_cliente
    @pessoa = Pessoa.find params[:pessoa_id]
  end
  
end
