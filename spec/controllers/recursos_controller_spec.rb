require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RecursosController do

  def mock_recurso(stubs={})
    @mock_recurso ||= mock_model(Recurso, stubs)
  end

  describe "GET index" do
    it "assigns all recursos as @recursos" do
      Recurso.stub!(:find).with(:all).and_return([mock_recurso])
      get :index
      assigns[:recursos].should == [mock_recurso]
    end
  end

  describe "GET show" do
    it "assigns the requested recurso as @recurso" do
      Recurso.stub!(:find).with("37").and_return(mock_recurso)
      get :show, :id => "37"
      assigns[:recurso].should equal(mock_recurso)
    end
  end

  describe "GET new" do
    it "assigns a new recurso as @recurso" do
      Recurso.stub!(:new).and_return(mock_recurso)
      get :new
      assigns[:recurso].should equal(mock_recurso)
    end
  end

  describe "GET edit" do
    it "assigns the requested recurso as @recurso" do
      Recurso.stub!(:find).with("37").and_return(mock_recurso)
      get :edit, :id => "37"
      assigns[:recurso].should equal(mock_recurso)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created recurso as @recurso" do
        Recurso.stub!(:new).with({'these' => 'params'}).and_return(mock_recurso(:save => true))
        post :create, :recurso => {:these => 'params'}
        assigns[:recurso].should equal(mock_recurso)
      end

      it "redirects to the created recurso" do
        Recurso.stub!(:new).and_return(mock_recurso(:save => true))
        post :create, :recurso => {}
        response.should redirect_to(recurso_url(mock_recurso))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recurso as @recurso" do
        Recurso.stub!(:new).with({'these' => 'params'}).and_return(mock_recurso(:save => false))
        post :create, :recurso => {:these => 'params'}
        assigns[:recurso].should equal(mock_recurso)
      end

      it "re-renders the 'new' template" do
        Recurso.stub!(:new).and_return(mock_recurso(:save => false))
        post :create, :recurso => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested recurso" do
        Recurso.should_receive(:find).with("37").and_return(mock_recurso)
        mock_recurso.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :recurso => {:these => 'params'}
      end

      it "assigns the requested recurso as @recurso" do
        Recurso.stub!(:find).and_return(mock_recurso(:update_attributes => true))
        put :update, :id => "1"
        assigns[:recurso].should equal(mock_recurso)
      end

      it "redirects to the recurso" do
        Recurso.stub!(:find).and_return(mock_recurso(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(recurso_url(mock_recurso))
      end
    end

    describe "with invalid params" do
      it "updates the requested recurso" do
        Recurso.should_receive(:find).with("37").and_return(mock_recurso)
        mock_recurso.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :recurso => {:these => 'params'}
      end

      it "assigns the recurso as @recurso" do
        Recurso.stub!(:find).and_return(mock_recurso(:update_attributes => false))
        put :update, :id => "1"
        assigns[:recurso].should equal(mock_recurso)
      end

      it "re-renders the 'edit' template" do
        Recurso.stub!(:find).and_return(mock_recurso(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested recurso" do
      Recurso.should_receive(:find).with("37").and_return(mock_recurso)
      mock_recurso.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the recursos list" do
      Recurso.stub!(:find).and_return(mock_recurso(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(recursos_url)
    end
  end

end
