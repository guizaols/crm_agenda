require 'spec_helper'

describe MoedasController do

  def mock_moeda(stubs={})
    @mock_moeda ||= mock_model(Moeda, stubs)
  end

  describe "GET index" do
    it "assigns all moedas as @moedas" do
      Moeda.stub(:find).with(:all).and_return([mock_moeda])
      get :index
      assigns[:moedas].should == [mock_moeda]
    end
  end

  describe "GET show" do
    it "assigns the requested moeda as @moeda" do
      Moeda.stub(:find).with("37").and_return(mock_moeda)
      get :show, :id => "37"
      assigns[:moeda].should equal(mock_moeda)
    end
  end

  describe "GET new" do
    it "assigns a new moeda as @moeda" do
      Moeda.stub(:new).and_return(mock_moeda)
      get :new
      assigns[:moeda].should equal(mock_moeda)
    end
  end

  describe "GET edit" do
    it "assigns the requested moeda as @moeda" do
      Moeda.stub(:find).with("37").and_return(mock_moeda)
      get :edit, :id => "37"
      assigns[:moeda].should equal(mock_moeda)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created moeda as @moeda" do
        Moeda.stub(:new).with({'these' => 'params'}).and_return(mock_moeda(:save => true))
        post :create, :moeda => {:these => 'params'}
        assigns[:moeda].should equal(mock_moeda)
      end

      it "redirects to the created moeda" do
        Moeda.stub(:new).and_return(mock_moeda(:save => true))
        post :create, :moeda => {}
        response.should redirect_to(moeda_url(mock_moeda))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved moeda as @moeda" do
        Moeda.stub(:new).with({'these' => 'params'}).and_return(mock_moeda(:save => false))
        post :create, :moeda => {:these => 'params'}
        assigns[:moeda].should equal(mock_moeda)
      end

      it "re-renders the 'new' template" do
        Moeda.stub(:new).and_return(mock_moeda(:save => false))
        post :create, :moeda => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested moeda" do
        Moeda.should_receive(:find).with("37").and_return(mock_moeda)
        mock_moeda.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :moeda => {:these => 'params'}
      end

      it "assigns the requested moeda as @moeda" do
        Moeda.stub(:find).and_return(mock_moeda(:update_attributes => true))
        put :update, :id => "1"
        assigns[:moeda].should equal(mock_moeda)
      end

      it "redirects to the moeda" do
        Moeda.stub(:find).and_return(mock_moeda(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(moeda_url(mock_moeda))
      end
    end

    describe "with invalid params" do
      it "updates the requested moeda" do
        Moeda.should_receive(:find).with("37").and_return(mock_moeda)
        mock_moeda.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :moeda => {:these => 'params'}
      end

      it "assigns the moeda as @moeda" do
        Moeda.stub(:find).and_return(mock_moeda(:update_attributes => false))
        put :update, :id => "1"
        assigns[:moeda].should equal(mock_moeda)
      end

      it "re-renders the 'edit' template" do
        Moeda.stub(:find).and_return(mock_moeda(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested moeda" do
      Moeda.should_receive(:find).with("37").and_return(mock_moeda)
      mock_moeda.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the moedas list" do
      Moeda.stub(:find).and_return(mock_moeda(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(moedas_url)
    end
  end

end
