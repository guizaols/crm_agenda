class GruposController < ApplicationController

  def index
    @grupos = Grupo.all(:order=>"nome ASC")
  end

  def show
    @grupo = Grupo.find(params[:id])
  end

  def new
    @grupo = Grupo.new
  end
  
  def edit
    @grupo = Grupo.find(params[:id])
  end

  def create
    @grupo = Grupo.new(params[:grupo])
    if @grupo.save
      flash[:notice] = 'Grupo criado com sucesso!'
      redirect_to(@grupo)
    else
      render :action => "new"
    end
  end

  def update
    @grupo = Grupo.find(params[:id])
    if @grupo.update_attributes(params[:grupo])
      flash[:notice] = 'Grupo atualizado com sucesso!'
      redirect_to(@grupo)
    else
      render :action => "edit"
    end
  end

  def destroy
    @grupo = Grupo.find(params[:id])
    @grupo.destroy
    redirect_to(grupos_url)
  end
  
end
  
