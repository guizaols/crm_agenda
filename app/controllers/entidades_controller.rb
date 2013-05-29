class EntidadesController < ApplicationController

  before_filter :verifica_se_eh_peugeot
  
  def index
    @entidades = Entidade.all(:order=>"nome ASC")
  end

  def show
    @entidade = Entidade.find(params[:id])
  end

  def new
    @entidade = Entidade.new
  end

  def edit
    @entidade = Entidade.find(params[:id])
  end

  def create
    @entidade = Entidade.new(params[:entidade])
    
      if @entidade.save
        flash[:notice] = 'Entidade criada com sucesso!'
        redirect_to(@entidade)
      else
         render :action => "new" 
      end
  end

  def update
    @entidade = Entidade.find(params[:id])

      if @entidade.update_attributes(params[:entidade])
        flash[:notice] = 'Entidade atualizada com sucesso!'
         redirect_to(@entidade) 
      else
         render :action => "edit"
      end
  end

  def destroy
    @entidade = Entidade.find(params[:id])
    @entidade.destroy
    redirect_to(entidades_url)
  end

  def cria_usuario
    @usuario = Usuario.new params[:usuario]
    render :update do |page|
      if @usuario.save
        page.alert 'Usuário salvo com sucesso!'
        page << "$('usuario_name').value = ''"
        page << "$('usuario_login').value = ''"
        page << "$('usuario_email').value = ''"
        page.reload
      else
        page.alert @usuario.errors.full_messages.collect{|item| "* #{item}"}.join("\n")
      end
    end
  end


  private
  def verifica_se_eh_peugeot
    if current_usuario.perfil_id != 3
      redirect_to "/"
    end
  end

end
