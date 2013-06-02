class HistoricoClientesController < ApplicationController

  before_filter :carrega_cliente

  def index
    @historicos = HistoricoCliente.find_all_by_pessoa_id(params[:pessoa_id], :order => " created_at DESC")
  end

  def show
    @historico = HistoricoCliente.find_by_id_and_pessoa_id(params[:id], params[:pessoa_id])
  end

  def new
    @historico = HistoricoCliente.new
  end

  def edit
    @historico = HistoricoCliente.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
  end

  def create
    @historico_cliente = HistoricoCliente.new(params[:historico_cliente])
    @historico_cliente.usuario_id = current_usuario.id
    @historico_cliente.pessoa_id = @pessoa.id

      if @historico_cliente.save
        flash[:notice] = 'Histórico do cliente foi criado com sucesso!'
                redirect_to pessoa_path(@pessoa)

      else
        render :action => "new"
      end
    end

  def update
    @historico_cliente = HistoricoCliente.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    @historico_cliente.usuario_id = current_usuario.id
    @historico_cliente.pessoa_id = @pessoa.id
    if @historico_cliente.update_attributes(params[:historico_cliente])
        flash[:notice] = 'Histórico do cliente atualizado com sucesso!'
        redirect_to pessoa_path(@pessoa)
      else
         render :action => "edit"
      end
  end

  def destroy
    @historico_cliente = HistoricoCliente.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    @historico_cliente.destroy
     redirect_to(historico_clientes_url)
  end



  private

  def carrega_cliente
    @pessoa = Pessoa.find(params[:pessoa_id])
  end

end
