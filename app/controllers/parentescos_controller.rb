class ParentescosController < ApplicationController

  before_filter :carrega_cliente

  def index
    @parentescos = Parentesco.find_all_by_pessoa_id(params[:pessoa_id], :order => 'nome ASC')
  end

  def show
    @parentesco = Parentesco.find_by_id_and_pessoa_id(params[:id], params[:pessoa_id])
  end

  def new
    @parentesco = Parentesco.new
  end

  def edit
    @parentesco = Parentesco.find_by_id_and_pessoa_id(params[:id], params[:pessoa_id])
  end

  def create
    @parentesco = Parentesco.new(params[:parentesco])
    @parentesco.usuario_id = current_usuario.id
    @parentesco.pessoa_id = @pessoa.id
    if @parentesco.save
      flash[:notice] = 'Parentesco criado com sucesso!'
      redirect_to pessoa_path(@pessoa)
    else
      render :action => 'new'
    end
  end

  def update
    @parentesco = Parentesco.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    @parentesco.usuario_id = current_usuario.id
    @parentesco.pessoa_id = @pessoa.id
    if @parentesco.update_attributes(params[:parentesco])
      flash[:notice] = 'Parentesco atualizado com sucesso!'
      redirect_to pessoa_path(@pessoa)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @parentesco = Parentesco.find_by_id_and_pessoa_id(params[:id], params[:pessoa_id])
    if @parentesco.destroy
      flash[:notice] = 'Parentesco exclúido com sucesso!'
    end
    redirect_to pessoa_path(@pessoa)
  end


private

  def carrega_cliente
    @pessoa = Pessoa.find(params[:pessoa_id])
  end

end
