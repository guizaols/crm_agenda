class SuportesController < ApplicationController



  def index
    @suportes = Suporte.find(:all,:conditions=>["status = 0"],:order=>"data DESC")
  end

  def aprovacao_tecnica
    @suporte = Suporte.find params[:id]
    render :update do |page|
      @suporte.aprovacao_tecnica = true
      if @suporte.save
        page.alert 'Estimativa técnica concluída com sucesso!'
        page.reload
      else
        page.alert 'Não foi possível realizar a estimativa técnica'
      end
    end
  end

  def aprovacao_administrativa
    @suporte = Suporte.find params[:id]
    render :update do |page|
      @suporte.aprovacao_adminsitrativa = true
      if @suporte.save
        page.alert 'Estimativa administrativa concluída com sucesso!'
        page.reload
      else
        page.alert 'Não foi possível realizar a estimativa administrativa'
      end
    end
  end

  def proposta_enviada
    @suporte = Suporte.find params[:id]
    render :update do |page|
      @suporte.proposta_enviada = true
      if @suporte.save
        @proposta = @suporte.proposta
         @proposta.valor_virtual = @proposta.valor
	 @proposta.status = 2
        @proposta.save!
        page.alert 'Status de envio da proposta concluído com sucesso!'
        page.reload
      else
        page.alert 'Não foi possível realizar a alteração no status da proposta'
      end
    end
  end


end
