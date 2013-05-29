class UsuariosController < ApplicationController

  @@display_name = 'Usuários'
  add_breadcrumb 'Usuários', 'usuarios_path'
  add_breadcrumb 'Novo Usuário', '', :only => [:new, :create]
  add_breadcrumb 'Alterando Usuário', '', :only => [:edit, :update]
  before_filter :verifica_se_eh_admin
  
  def index
    if current_usuario.perfil_id == 3
      @usuarios = Usuario.all(:order=>"name ASC")
    else
      @usuarios = Usuario.find(:all,:conditions=>["entidade_id = ?",current_usuario.entidade_id],:order=>"name ASC")
    end
  end
  
  def new
    @usuario = Usuario.new
  end
 
  def create
    @usuario = Usuario.new(params[:usuario])
    @usuario.entidade_id = current_usuario.entidade_id if current_usuario.perfil_id != 3
    success = @usuario && @usuario.save
    if success && @usuario.errors.empty?
      redirect_to usuarios_path
      flash[:notice] = "Usuário cadastrado com sucesso!"
    else
      render :action => 'new'
    end
  end
  
  def edit
    @usuario = Usuario.find(params[:id])
  end
  
  def update
    @usuario = Usuario.find(params[:id])
       @usuario.entidade_id = current_usuario.entidade_id if current_usuario.perfil_id != 3
    if@usuario.update_attributes(params[:usuario])
      flash[:notice] = 'Usuário atualizado com sucesso!'
      redirect_to usuarios_path
    else
      render :action=>'edit'  
    end
  end
  
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    redirect_to usuarios_path
  end

    private

  def verifica_se_eh_admin
    if current_usuario.perfil_id == 2
      redirect_to "/"
    end
  end
  
end
