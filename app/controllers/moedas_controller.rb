class MoedasController < ApplicationController

  def index
    @moedas = Moeda.all(:order=>"nome ASC")
  end

  def show
    @moeda = Moeda.find(params[:id])
  end

  def new
    @moeda = Moeda.new
  end

  def edit
    @moeda = Moeda.find(params[:id])
  end

  def create
    @moeda = Moeda.new(params[:moeda])
    if @moeda.save
      flash[:notice] = 'Moeda criada com sucesso!'
      redirect_to(@moeda)
    else
      render :action => "new"
    end
  end
 
  def update
    @moeda = Moeda.find(params[:id])
    if @moeda.update_attributes(params[:moeda])
      flash[:notice] = 'Moeda atualizada com sucesso!'
      redirect_to(@moeda)
    else
      render :action => "edit"
    end
  end

  def destroy
    @moeda = Moeda.find(params[:id])
    @moeda.destroy
    redirect_to(moedas_url)
  end
end
