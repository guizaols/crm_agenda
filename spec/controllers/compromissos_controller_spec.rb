require 'spec_helper'

describe CompromissosController do

  def mock_compromisso(stubs={})
    @mock_compromisso ||= mock_model(Compromisso, stubs)
  end

  describe "GET index" do
    it "assigns all compromissos as @compromissos" do
      Compromisso.stub(:find).with(:all).and_return([mock_compromisso])
      get :index
      assigns[:compromissos].should == [mock_compromisso]
    end
  end

  describe "GET show" do
    it "assigns the requested compromisso as @compromisso" do
      Compromisso.stub(:find).with("37").and_return(mock_compromisso)
      get :show, :id => "37"
      assigns[:compromisso].should equal(mock_compromisso)
    end
  end

  describe "GET new" do
    it "assigns a new compromisso as @compromisso" do
      Compromisso.stub(:new).and_return(mock_compromisso)
      get :new
      assigns[:compromisso].should equal(mock_compromisso)
    end
  end

  describe "GET edit" do
    it "assigns the requested compromisso as @compromisso" do
      Compromisso.stub(:find).with("37").and_return(mock_compromisso)
      get :edit, :id => "37"
      assigns[:compromisso].should equal(mock_compromisso)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created compromisso as @compromisso" do
        Compromisso.stub(:new).with({'these' => 'params'}).and_return(mock_compromisso(:save => true))
        post :create, :compromisso => {:these => 'params'}
        assigns[:compromisso].should equal(mock_compromisso)
      end

      it "redirects to the created compromisso" do
        Compromisso.stub(:new).and_return(mock_compromisso(:save => true))
        post :create, :compromisso => {}
        response.should redirect_to(compromisso_url(mock_compromisso))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved compromisso as @compromisso" do
        Compromisso.stub(:new).with({'these' => 'params'}).and_return(mock_compromisso(:save => false))
        post :create, :compromisso => {:these => 'params'}
        assigns[:compromisso].should equal(mock_compromisso)
      end

      it "re-renders the 'new' template" do
        Compromisso.stub(:new).and_return(mock_compromisso(:save => false))
        post :create, :compromisso => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested compromisso" do
        Compromisso.should_receive(:find).with("37").and_return(mock_compromisso)
        mock_compromisso.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :compromisso => {:these => 'params'}
      end

      it "assigns the requested compromisso as @compromisso" do
        Compromisso.stub(:find).and_return(mock_compromisso(:update_attributes => true))
        put :update, :id => "1"
        assigns[:compromisso].should equal(mock_compromisso)
      end

      it "redirects to the compromisso" do
        Compromisso.stub(:find).and_return(mock_compromisso(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(compromisso_url(mock_compromisso))
      end
    end

    describe "with invalid params" do
      it "updates the requested compromisso" do
        Compromisso.should_receive(:find).with("37").and_return(mock_compromisso)
        mock_compromisso.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :compromisso => {:these => 'params'}
      end

      it "assigns the compromisso as @compromisso" do
        Compromisso.stub(:find).and_return(mock_compromisso(:update_attributes => false))
        put :update, :id => "1"
        assigns[:compromisso].should equal(mock_compromisso)
      end

      it "re-renders the 'edit' template" do
        Compromisso.stub(:find).and_return(mock_compromisso(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested compromisso" do
      Compromisso.should_receive(:find).with("37").and_return(mock_compromisso)
      mock_compromisso.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the compromissos list" do
      Compromisso.stub(:find).and_return(mock_compromisso(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(compromissos_url)
    end
  end

end
