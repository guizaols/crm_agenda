require 'spec_helper'

describe OrigensController do

  def mock_origem(stubs={})
    @mock_origem ||= mock_model(Origem, stubs)
  end

  describe "GET index" do
    it "assigns all origens as @origens" do
      Origem.stub!(:find).with(:all).and_return([mock_origem])
      get :index
      assigns[:origens].should == [mock_origem]
    end
  end

  describe "GET show" do
    it "assigns the requested origem as @origem" do
      Origem.stub!(:find).with("37").and_return(mock_origem)
      get :show, :id => "37"
      assigns[:origem].should equal(mock_origem)
    end
  end

  describe "GET new" do
    it "assigns a new origem as @origem" do
      Origem.stub!(:new).and_return(mock_origem)
      get :new
      assigns[:origem].should equal(mock_origem)
    end
  end

  describe "GET edit" do
    it "assigns the requested origem as @origem" do
      Origem.stub!(:find).with("37").and_return(mock_origem)
      get :edit, :id => "37"
      assigns[:origem].should equal(mock_origem)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created origem as @origem" do
        Origem.stub!(:new).with({'these' => 'params'}).and_return(mock_origem(:save => true))
        post :create, :origem => {:these => 'params'}
        assigns[:origem].should equal(mock_origem)
      end

      it "redirects to the created origem" do
        Origem.stub!(:new).and_return(mock_origem(:save => true))
        post :create, :origem => {}
        response.should redirect_to(origem_url(mock_origem))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved origem as @origem" do
        Origem.stub!(:new).with({'these' => 'params'}).and_return(mock_origem(:save => false))
        post :create, :origem => {:these => 'params'}
        assigns[:origem].should equal(mock_origem)
      end

      it "re-renders the 'new' template" do
        Origem.stub!(:new).and_return(mock_origem(:save => false))
        post :create, :origem => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested origem" do
        Origem.should_receive(:find).with("37").and_return(mock_origem)
        mock_origem.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :origem => {:these => 'params'}
      end

      it "assigns the requested origem as @origem" do
        Origem.stub!(:find).and_return(mock_origem(:update_attributes => true))
        put :update, :id => "1"
        assigns[:origem].should equal(mock_origem)
      end

      it "redirects to the origem" do
        Origem.stub!(:find).and_return(mock_origem(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(origem_url(mock_origem))
      end
    end

    describe "with invalid params" do
      it "updates the requested origem" do
        Origem.should_receive(:find).with("37").and_return(mock_origem)
        mock_origem.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :origem => {:these => 'params'}
      end

      it "assigns the origem as @origem" do
        Origem.stub!(:find).and_return(mock_origem(:update_attributes => false))
        put :update, :id => "1"
        assigns[:origem].should equal(mock_origem)
      end

      it "re-renders the 'edit' template" do
        Origem.stub!(:find).and_return(mock_origem(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested origem" do
      Origem.should_receive(:find).with("37").and_return(mock_origem)
      mock_origem.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the origens list" do
      Origem.stub!(:find).and_return(mock_origem(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(origens_url)
    end
  end

end
