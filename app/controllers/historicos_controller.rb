class HistoricosController < ApplicationController

before_filter :carrega_proposta

  def new
    @historico = Historico.new
  end

  def show
    @historico = Historico.find_by_id_and_proposta_id(params[:id],params[:proposta_id])
  end

  def edit
    @historico = Historico.find_by_id_and_proposta_id(params[:id],params[:proposta_id])
  end

  def destroy
    @historico = Historico.find_by_id_and_proposta_id(params[:id],params[:proposta_id])
    @historico.destroy
    flash[:notice] = "Histórico apagado com sucesso!"
    redirect_to pessoa_proposta_path(@proposta.pessoa,@proposta)
  end

  def create
    @historico = Historico.new(params[:historico])
    @historico.usuario_id = current_usuario.id
    @historico.proposta = @proposta
    @historico.pessoa_id = @proposta.pessoa.id
      if @historico.save
         Auditoria.create :data=>Date.today.to_s_br,:operacao=>"Histórico Criado",:usuario_id=>current_usuario.id,:entidade_id=>current_usuario.entidade_id,:pessoa_id=>@proposta.pessoa.id,:proposta_id=>@proposta.id,:historico_id=>@historico.id
        flash[:notice] = 'Histórico criado com sucesso!'
         redirect_to pessoa_proposta_path(@proposta.pessoa,@proposta)
    else
      render :action => "new"
    end
  end

  def update
    @historico = Historico.find(params[:id])
      if @historico.update_attributes(params[:historico])
        Auditoria.create :data=>Date.today.to_s_br,:operacao=>"Histórico Atualizado",:entidade_id=>current_usuario.entidade_id,:usuario_id=>current_usuario.id,:pessoa_id=>@proposta.pessoa.id,:proposta_id=>@proposta.id,:historico_id=>@historico.id
        flash[:notice] = 'Histórico atualizado com sucesso!'
        redirect_to pessoa_proposta_path(@proposta.pessoa,@proposta)
      else
        render :action => "edit"
    end
  end

  private

  def carrega_proposta
    @proposta = Proposta.find params[:proposta_id]
  end
end
