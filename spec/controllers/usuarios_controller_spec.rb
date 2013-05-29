require File.dirname(__FILE__) + '/../spec_helper'

describe UsuariosController do
  fixtures :usuarios
  integrate_views
  
  it 'Verifica se existe a action index' do
    login_as :quentin
    get :index, :locale=>'pt'
    response.should be_success
  end
  
  it 'Verifica se existe a action index e nao deixa acessar caso usuario não esteja logado' do
    get :index, :locale=>'pt'
    response.should redirect_to(new_sessao_path)
  end
  
  it 'Verifica se existe a action new' do
    login_as :quentin
    get :new , :locale=>'pt'
    response.should be_success
    response.should have_tag('form[action=?][method=post]',usuarios_path) do
      with_tag('input[name=?]','usuario[login]')
      with_tag('input[name=?]','usuario[email]')
      with_tag('input[name=?][type=?]','usuario[password]','password')
      with_tag('input[name=?][type=?]','usuario[password_confirmation]','password')
      with_tag('input[type=?]','submit')
    end
  end
  
  it 'Verifica se existe a action new e redireciona caso o usuario não esteja logado' do
    get :new, :locale=>'pt'
    response.should redirect_to(new_sessao_path)
  end
  
  it 'Verifica se existe a action edit' do
    login_as :quentin
    usuario = usuarios(:quentin)
    get :edit, :locale=>'pt', :id => usuario.id 
    response.should be_success
  end
  
  it 'Verifica se existe a action edit e redireciona caso o usuario não esteja logado' do
    usuario = usuarios(:quentin)
    get :edit, :locale=>'pt', :id => usuario.id 
    response.should redirect_to(new_sessao_path)
  end
  
  it 'Verifica se existe a action update e atualiza com sucesso' do
    login_as :quentin
    usuario = usuarios(:quentin)
    put :update, :locale=>'pt', :id=> usuario.id , :usuario => { :login => 'juka', :email => 'juka@example.com',
      :password => 'juka29', :password_confirmation => 'juka29' }
    response.should redirect_to(usuarios_path)
  end
  
  it 'Verifica se existe a action update e não consegue atualizar dados do usuario com sucesso' do
    login_as :quentin
    usuario = usuarios(:quentin)
    put :update, :locale=>'pt', :id=> usuario.id , :usuario => { :login => 'juka', :email => 'juka@example.com',
      :password => 'juka29', :password_confirmation => '' }
    response.should render_template('edit')
  end
  
  it 'Verifica se existe a action update e redireciona quando o usuario não tem acesso' do
    usuario = usuarios(:quentin)
    put :update, :locale=>'pt', :id=> usuario.id , :usuario => { :login => 'juka', :email => 'juka@example.com',
      :password => 'juka29', :password_confirmation => 'juka29' }
    response.should redirect_to(new_sessao_path)
  end

  it 'allows signup' do
    login_as :quentin
    lambda do
      create_usuario
      response.should redirect_to(usuarios_path)
    end.should change(Usuario, :count).by(1)
  end

  it 'requires login on signup' do
    login_as :quentin
    lambda do
      create_usuario(:login => nil)
      assigns[:usuario].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Usuario, :count)
  end
  
  it 'requires password on signup' do
    login_as :quentin
    lambda do
      create_usuario(:password => nil)
      assigns[:usuario].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Usuario, :count)
  end
  
  it 'requires password confirmation on signup' do
    login_as :quentin
    lambda do
      create_usuario(:password_confirmation => nil)
      assigns[:usuario].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Usuario, :count)
  end

  it 'requires email on signup' do
    login_as :quentin
    lambda do
      create_usuario(:email => nil)
      assigns[:usuario].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Usuario, :count)
  end
  
  
  
  def create_usuario(options = {})
    post :create,:locale=>'pt' ,:usuario => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire69', :password_confirmation => 'quire69', :name => 'Quire' }.merge(options)
  end
  
  it 'Verifica se existe a action destroy e consegue apagar' do
    login_as :quentin
    lambda do
      usuario = usuarios(:quentin)
      delete :destroy, :locale=>'pt', :id=> usuario.id
      response.should redirect_to(usuarios_path)
    end.should change(Usuario, :count).by(-1)
  end
  
  it 'Verifica se existe a action destroy e redireciona quando o usuario não possui acesso' do
    lambda do
      usuario = usuarios(:quentin)
      delete :destroy, :locale=>'pt', :id=> usuario.id
      response.should redirect_to(new_sessao_path)
    end.should change(Usuario, :count).by(0)
  end
  
end
