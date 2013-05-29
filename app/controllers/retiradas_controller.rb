class RetiradasController < ApplicationController

  def index
    params[:busca] ||= {}
    if params[:busca].blank?
      if current_usuario.perfil_id == 2
        @retiradas = Retirada.all(:conditions=>["usuario_id = ?",current_usuario.id],:order=>["data_retirada DESC"])
      elsif current_usuario.perfil_id == 1
        @retiradas = Retirada.all(:conditions=>["entidade_id = ?",current_usuario.entidade_id],:order=>["data_retirada DESC"])
      else
           @retiradas = Retirada.all(:order=>["data_retirada DESC"])
      end
    else
      @retiradas = Retirada.busca_retirada(current_usuario,params[:busca])
  end

  end

  def show
    @retirada = Retirada.find(params[:id])
  end

  def new
    @retirada = Retirada.new
  end

  def edit
    @retirada = Retirada.find(params[:id])
  end

  def create
    @retirada = Retirada.new(params[:retirada])
    @retirada.usuario_id = current_usuario.id
    if @retirada.save
      flash[:notice] = 'Retirada criada com sucesso!'
      redirect_to(@retirada)
    else
      render :action => "new"
    end
  end

  def update
    @retirada = Retirada.find(params[:id])
    @retirada.usuario_id = current_usuario.id
    if @retirada.update_attributes(params[:retirada])
      flash[:notice] = 'Retirada atualizada com sucesso!'
      redirect_to(@retirada)
    else
      render :action => "edit"
    end
  end

  def destroy
    @retirada = Retirada.find(params[:id])
    @retirada.destroy
    redirect_to(retiradas_url) 
  end
end
