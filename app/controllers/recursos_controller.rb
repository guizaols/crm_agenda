class RecursosController < ApplicationController
  def index
    if current_usuario.perfil_id == 3
    @recursos = Recurso.all
    else
      @recursos = Recurso.find(:all,:conditions=>["entidade_id = ?",current_usuario.entidade_id])
    end
  end

  def show
    @recurso = Recurso.find(params[:id])
  end

  def new
    @recurso = Recurso.new
  end

  def edit
    @recurso = Recurso.find(params[:id])
  end

  def create
    @recurso = Recurso.new(params[:recurso])
    @recurso.entidade_id = current_usuario.entidade_id if current_usuario.perfil_id != 3
    if @recurso.save
      flash[:notice] = 'Recurso criado com sucesso!'
      redirect_to(@recurso)
    else
      render :action => "new"
    end
  end

  def update
    @recurso = Recurso.find(params[:id])
        @recurso.entidade_id = current_usuario.entidade_id if current_usuario.perfil_id != 3
    if @recurso.update_attributes(params[:recurso])
      flash[:notice] = 'Recurso atualizado com sucesso!'
      redirect_to(@recurso)
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @recurso = Recurso.find(params[:id])
    @recurso.destroy
    redirect_to(recursos_url)
  end
end
