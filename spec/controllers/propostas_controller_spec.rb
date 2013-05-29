require 'spec_helper'

describe PropostasController do

  def mock_proposta(stubs={})
    @mock_proposta ||= mock_model(Proposta, stubs)
  end

  describe "GET index" do
    it "assigns all propostas as @propostas" do
      Proposta.stub(:find).with(:all).and_return([mock_proposta])
      get :index
      assigns[:propostas].should == [mock_proposta]
    end
  end

  describe "GET show" do
    it "assigns the requested proposta as @proposta" do
      Proposta.stub(:find).with("37").and_return(mock_proposta)
      get :show, :id => "37"
      assigns[:proposta].should equal(mock_proposta)
    end
  end

  describe "GET new" do
    it "assigns a new proposta as @proposta" do
      Proposta.stub(:new).and_return(mock_proposta)
      get :new
      assigns[:proposta].should equal(mock_proposta)
    end
  end

  describe "GET edit" do
    it "assigns the requested proposta as @proposta" do
      Proposta.stub(:find).with("37").and_return(mock_proposta)
      get :edit, :id => "37"
      assigns[:proposta].should equal(mock_proposta)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created proposta as @proposta" do
        Proposta.stub(:new).with({'these' => 'params'}).and_return(mock_proposta(:save => true))
        post :create, :proposta => {:these => 'params'}
        assigns[:proposta].should equal(mock_proposta)
      end

      it "redirects to the created proposta" do
        Proposta.stub(:new).and_return(mock_proposta(:save => true))
        post :create, :proposta => {}
        response.should redirect_to(proposta_url(mock_proposta))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved proposta as @proposta" do
        Proposta.stub(:new).with({'these' => 'params'}).and_return(mock_proposta(:save => false))
        post :create, :proposta => {:these => 'params'}
        assigns[:proposta].should equal(mock_proposta)
      end

      it "re-renders the 'new' template" do
        Proposta.stub(:new).and_return(mock_proposta(:save => false))
        post :create, :proposta => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested proposta" do
        Proposta.should_receive(:find).with("37").and_return(mock_proposta)
        mock_proposta.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :proposta => {:these => 'params'}
      end

      it "assigns the requested proposta as @proposta" do
        Proposta.stub(:find).and_return(mock_proposta(:update_attributes => true))
        put :update, :id => "1"
        assigns[:proposta].should equal(mock_proposta)
      end

      it "redirects to the proposta" do
        Proposta.stub(:find).and_return(mock_proposta(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(proposta_url(mock_proposta))
      end
    end

    describe "with invalid params" do
      it "updates the requested proposta" do
        Proposta.should_receive(:find).with("37").and_return(mock_proposta)
        mock_proposta.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :proposta => {:these => 'params'}
      end

      it "assigns the proposta as @proposta" do
        Proposta.stub(:find).and_return(mock_proposta(:update_attributes => false))
        put :update, :id => "1"
        assigns[:proposta].should equal(mock_proposta)
      end

      it "re-renders the 'edit' template" do
        Proposta.stub(:find).and_return(mock_proposta(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested proposta" do
      Proposta.should_receive(:find).with("37").and_return(mock_proposta)
      mock_proposta.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the propostas list" do
      Proposta.stub(:find).and_return(mock_proposta(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(propostas_url)
    end
  end

end
