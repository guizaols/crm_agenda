class TipoCompromissosController < ApplicationController

  def index
    @tipo_compromissos = TipoCompromisso.all
  end

  def show
    @tipo_compromisso = TipoCompromisso.find(params[:id])
end

  def new
    @tipo_compromisso = TipoCompromisso.new

  end

  def edit
    @tipo_compromisso = TipoCompromisso.find(params[:id])
  end

  def create
    @tipo_compromisso = TipoCompromisso.new(params[:tipo_compromisso])
      if @tipo_compromisso.save
        flash[:notice] = 'Tipo de Compromisso cadastrado com sucesso!'
        redirect_to(@tipo_compromisso) 
      else
          render :action => "new"
      end
  end

  def update
    @tipo_compromisso = TipoCompromisso.find(params[:id])

      if @tipo_compromisso.update_attributes(params[:tipo_compromisso])
        flash[:notice] = 'Tipo de Compromisso atualizado com sucesso!'
 redirect_to(@tipo_compromisso) 
      else
        render :action => "edit" 
      end
  end

  def destroy
    @tipo_compromisso = TipoCompromisso.find(params[:id])
    @tipo_compromisso.destroy

  redirect_to(tipo_compromissos_url) 
  end
end
