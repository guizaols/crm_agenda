class ProdutosController < ApplicationController

  before_filter :verificar_iphone,:only=>[:index]
  before_filter :iphone_request?,:only=>[:index]
  before_filter :mobile_request?,:only=>[:index]


  def index
    if current_usuario.perfil_id == 3
    @produtos = Produto.all(:order=>"nome ASC")
    else
      @produtos = Produto.find(:all,:conditions=>["entidade_id = ?",current_usuario.entidade_id])
    end
  end

  def show
    @produto = Produto.find(params[:id])
  end

  def new
    @produto = Produto.new
  end

  def edit
    @produto = Produto.find(params[:id])
  end

 
  def create
    @produto = Produto.new(params[:produto])
    @produto.entidade_id = current_usuario.entidade_id if current_usuario.perfil_id != 3
    if @produto.save
      if  (!params[:arquivo].blank? && params[:arquivo].length > 0)
        filepath = RAILS_ROOT + "/public/recursos/#{@produto.id}.jpg"
        File.open(filepath, "wb") do |f|
          f.write(params[:arquivo].read)
        end
      end
      flash[:notice] = 'Produto criado com sucesso!'
      redirect_to(@produto)
    else
      render :action => "new"
    end
  end

  def update
    @produto = Produto.find(params[:id])
    @produto.entidade_id = current_usuario.entidade_id if current_usuario.perfil_id != 3
    if @produto.update_attributes(params[:produto])
          if (!params[:arquivo].blank? && params[:arquivo].length > 0)
        filepath = RAILS_ROOT + "/public/recursos/#{@produto.id}.jpg"
        File.open(filepath, "wb") do |f|
          f.write(params[:arquivo].read)
        end
      end
      flash[:notice] = 'Produto atualizado com sucesso!'
      redirect_to(@produto)
    else
      render :action => "edit"
    end
  end


end
