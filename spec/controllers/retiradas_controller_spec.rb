require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RetiradasController do

  def mock_retirada(stubs={})
    @mock_retirada ||= mock_model(Retirada, stubs)
  end

  describe "GET index" do
    it "assigns all retiradas as @retiradas" do
      Retirada.stub!(:find).with(:all).and_return([mock_retirada])
      get :index
      assigns[:retiradas].should == [mock_retirada]
    end
  end

  describe "GET show" do
    it "assigns the requested retirada as @retirada" do
      Retirada.stub!(:find).with("37").and_return(mock_retirada)
      get :show, :id => "37"
      assigns[:retirada].should equal(mock_retirada)
    end
  end

  describe "GET new" do
    it "assigns a new retirada as @retirada" do
      Retirada.stub!(:new).and_return(mock_retirada)
      get :new
      assigns[:retirada].should equal(mock_retirada)
    end
  end

  describe "GET edit" do
    it "assigns the requested retirada as @retirada" do
      Retirada.stub!(:find).with("37").and_return(mock_retirada)
      get :edit, :id => "37"
      assigns[:retirada].should equal(mock_retirada)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created retirada as @retirada" do
        Retirada.stub!(:new).with({'these' => 'params'}).and_return(mock_retirada(:save => true))
        post :create, :retirada => {:these => 'params'}
        assigns[:retirada].should equal(mock_retirada)
      end

      it "redirects to the created retirada" do
        Retirada.stub!(:new).and_return(mock_retirada(:save => true))
        post :create, :retirada => {}
        response.should redirect_to(retirada_url(mock_retirada))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved retirada as @retirada" do
        Retirada.stub!(:new).with({'these' => 'params'}).and_return(mock_retirada(:save => false))
        post :create, :retirada => {:these => 'params'}
        assigns[:retirada].should equal(mock_retirada)
      end

      it "re-renders the 'new' template" do
        Retirada.stub!(:new).and_return(mock_retirada(:save => false))
        post :create, :retirada => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested retirada" do
        Retirada.should_receive(:find).with("37").and_return(mock_retirada)
        mock_retirada.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :retirada => {:these => 'params'}
      end

      it "assigns the requested retirada as @retirada" do
        Retirada.stub!(:find).and_return(mock_retirada(:update_attributes => true))
        put :update, :id => "1"
        assigns[:retirada].should equal(mock_retirada)
      end

      it "redirects to the retirada" do
        Retirada.stub!(:find).and_return(mock_retirada(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(retirada_url(mock_retirada))
      end
    end

    describe "with invalid params" do
      it "updates the requested retirada" do
        Retirada.should_receive(:find).with("37").and_return(mock_retirada)
        mock_retirada.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :retirada => {:these => 'params'}
      end

      it "assigns the retirada as @retirada" do
        Retirada.stub!(:find).and_return(mock_retirada(:update_attributes => false))
        put :update, :id => "1"
        assigns[:retirada].should equal(mock_retirada)
      end

      it "re-renders the 'edit' template" do
        Retirada.stub!(:find).and_return(mock_retirada(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested retirada" do
      Retirada.should_receive(:find).with("37").and_return(mock_retirada)
      mock_retirada.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the retiradas list" do
      Retirada.stub!(:find).and_return(mock_retirada(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(retiradas_url)
    end
  end

end
