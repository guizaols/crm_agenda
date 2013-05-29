# This controller handles the login/logout function of the site.  
class SessoesController < ApplicationController

  @@display_name = 'Login'
  add_breadcrumb 'Login', 'login_path'

  before_filter :verificar_iphone
  before_filter :iphone_request?
  before_filter :mobile_request?
  skip_before_filter :login_required
  
  def new
  end

  def create
    logout_keeping_session!
    usuario = Usuario.authenticate(params[:login], params[:password])
    if usuario
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_usuario = usuario
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      
      if usuario.perfil_id == 2 || usuario.perfil_id == 4 || usuario.perfil_id == 5
         redirect_to main_path
      else
        redirect_to minha_empresa_path
      end



      flash[:notice] = "Bem vindo!"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "Sua sessão foi encerrada."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:notice] = "Dados incorretos!"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
