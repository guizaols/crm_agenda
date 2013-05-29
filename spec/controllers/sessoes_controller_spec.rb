require File.dirname(__FILE__) + '/../spec_helper'

describe SessoesController do

  integrate_views
  
  it 'deve exibir pagina de login' do
    get :new
    response.should be_success
  end

  it 'deve autenticar e gravar sessao' do
    post :create, :login => 'quentin', :password => 'monkey'
    response.should redirect_to('/')
    response.session[:usuario_id].should == usuarios(:quentin).id
  end

  it 'deve efetuar logout' do
    get :destroy
    response.should redirect_to('/')
    response.session[:usuario_id].should == nil
  end

end
