require 'spec_helper'

describe TipoCompromissosController do

  def mock_tipo_compromisso(stubs={})
    @mock_tipo_compromisso ||= mock_model(TipoCompromisso, stubs)
  end

  describe "GET index" do
    it "assigns all tipo_compromissos as @tipo_compromissos" do
      TipoCompromisso.stub(:find).with(:all).and_return([mock_tipo_compromisso])
      get :index
      assigns[:tipo_compromissos].should == [mock_tipo_compromisso]
    end
  end

  describe "GET show" do
    it "assigns the requested tipo_compromisso as @tipo_compromisso" do
      TipoCompromisso.stub(:find).with("37").and_return(mock_tipo_compromisso)
      get :show, :id => "37"
      assigns[:tipo_compromisso].should equal(mock_tipo_compromisso)
    end
  end

  describe "GET new" do
    it "assigns a new tipo_compromisso as @tipo_compromisso" do
      TipoCompromisso.stub(:new).and_return(mock_tipo_compromisso)
      get :new
      assigns[:tipo_compromisso].should equal(mock_tipo_compromisso)
    end
  end

  describe "GET edit" do
    it "assigns the requested tipo_compromisso as @tipo_compromisso" do
      TipoCompromisso.stub(:find).with("37").and_return(mock_tipo_compromisso)
      get :edit, :id => "37"
      assigns[:tipo_compromisso].should equal(mock_tipo_compromisso)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created tipo_compromisso as @tipo_compromisso" do
        TipoCompromisso.stub(:new).with({'these' => 'params'}).and_return(mock_tipo_compromisso(:save => true))
        post :create, :tipo_compromisso => {:these => 'params'}
        assigns[:tipo_compromisso].should equal(mock_tipo_compromisso)
      end

      it "redirects to the created tipo_compromisso" do
        TipoCompromisso.stub(:new).and_return(mock_tipo_compromisso(:save => true))
        post :create, :tipo_compromisso => {}
        response.should redirect_to(tipo_compromisso_url(mock_tipo_compromisso))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tipo_compromisso as @tipo_compromisso" do
        TipoCompromisso.stub(:new).with({'these' => 'params'}).and_return(mock_tipo_compromisso(:save => false))
        post :create, :tipo_compromisso => {:these => 'params'}
        assigns[:tipo_compromisso].should equal(mock_tipo_compromisso)
      end

      it "re-renders the 'new' template" do
        TipoCompromisso.stub(:new).and_return(mock_tipo_compromisso(:save => false))
        post :create, :tipo_compromisso => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested tipo_compromisso" do
        TipoCompromisso.should_receive(:find).with("37").and_return(mock_tipo_compromisso)
        mock_tipo_compromisso.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tipo_compromisso => {:these => 'params'}
      end

      it "assigns the requested tipo_compromisso as @tipo_compromisso" do
        TipoCompromisso.stub(:find).and_return(mock_tipo_compromisso(:update_attributes => true))
        put :update, :id => "1"
        assigns[:tipo_compromisso].should equal(mock_tipo_compromisso)
      end

      it "redirects to the tipo_compromisso" do
        TipoCompromisso.stub(:find).and_return(mock_tipo_compromisso(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(tipo_compromisso_url(mock_tipo_compromisso))
      end
    end

    describe "with invalid params" do
      it "updates the requested tipo_compromisso" do
        TipoCompromisso.should_receive(:find).with("37").and_return(mock_tipo_compromisso)
        mock_tipo_compromisso.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tipo_compromisso => {:these => 'params'}
      end

      it "assigns the tipo_compromisso as @tipo_compromisso" do
        TipoCompromisso.stub(:find).and_return(mock_tipo_compromisso(:update_attributes => false))
        put :update, :id => "1"
        assigns[:tipo_compromisso].should equal(mock_tipo_compromisso)
      end

      it "re-renders the 'edit' template" do
        TipoCompromisso.stub(:find).and_return(mock_tipo_compromisso(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested tipo_compromisso" do
      TipoCompromisso.should_receive(:find).with("37").and_return(mock_tipo_compromisso)
      mock_tipo_compromisso.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tipo_compromissos list" do
      TipoCompromisso.stub(:find).and_return(mock_tipo_compromisso(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(tipo_compromissos_url)
    end
  end

end
