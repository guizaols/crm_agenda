require 'spec_helper'

describe HistoricosController do

  def mock_historico(stubs={})
    @mock_historico ||= mock_model(Historico, stubs)
  end

  describe "GET index" do
    it "assigns all historicos as @historicos" do
      Historico.stub(:find).with(:all).and_return([mock_historico])
      get :index
      assigns[:historicos].should == [mock_historico]
    end
  end

  describe "GET show" do
    it "assigns the requested historico as @historico" do
      Historico.stub(:find).with("37").and_return(mock_historico)
      get :show, :id => "37"
      assigns[:historico].should equal(mock_historico)
    end
  end

  describe "GET new" do
    it "assigns a new historico as @historico" do
      Historico.stub(:new).and_return(mock_historico)
      get :new
      assigns[:historico].should equal(mock_historico)
    end
  end

  describe "GET edit" do
    it "assigns the requested historico as @historico" do
      Historico.stub(:find).with("37").and_return(mock_historico)
      get :edit, :id => "37"
      assigns[:historico].should equal(mock_historico)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created historico as @historico" do
        Historico.stub(:new).with({'these' => 'params'}).and_return(mock_historico(:save => true))
        post :create, :historico => {:these => 'params'}
        assigns[:historico].should equal(mock_historico)
      end

      it "redirects to the created historico" do
        Historico.stub(:new).and_return(mock_historico(:save => true))
        post :create, :historico => {}
        response.should redirect_to(historico_url(mock_historico))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved historico as @historico" do
        Historico.stub(:new).with({'these' => 'params'}).and_return(mock_historico(:save => false))
        post :create, :historico => {:these => 'params'}
        assigns[:historico].should equal(mock_historico)
      end

      it "re-renders the 'new' template" do
        Historico.stub(:new).and_return(mock_historico(:save => false))
        post :create, :historico => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested historico" do
        Historico.should_receive(:find).with("37").and_return(mock_historico)
        mock_historico.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :historico => {:these => 'params'}
      end

      it "assigns the requested historico as @historico" do
        Historico.stub(:find).and_return(mock_historico(:update_attributes => true))
        put :update, :id => "1"
        assigns[:historico].should equal(mock_historico)
      end

      it "redirects to the historico" do
        Historico.stub(:find).and_return(mock_historico(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(historico_url(mock_historico))
      end
    end

    describe "with invalid params" do
      it "updates the requested historico" do
        Historico.should_receive(:find).with("37").and_return(mock_historico)
        mock_historico.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :historico => {:these => 'params'}
      end

      it "assigns the historico as @historico" do
        Historico.stub(:find).and_return(mock_historico(:update_attributes => false))
        put :update, :id => "1"
        assigns[:historico].should equal(mock_historico)
      end

      it "re-renders the 'edit' template" do
        Historico.stub(:find).and_return(mock_historico(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested historico" do
      Historico.should_receive(:find).with("37").and_return(mock_historico)
      mock_historico.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the historicos list" do
      Historico.stub(:find).and_return(mock_historico(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(historicos_url)
    end
  end

end
