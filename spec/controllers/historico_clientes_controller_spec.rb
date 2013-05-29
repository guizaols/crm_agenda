require 'spec_helper'

describe HistoricoClientesController do

  def mock_historico_cliente(stubs={})
    @mock_historico_cliente ||= mock_model(HistoricoCliente, stubs)
  end

  describe "GET index" do
    it "assigns all historico_clientes as @historico_clientes" do
      HistoricoCliente.stub!(:find).with(:all).and_return([mock_historico_cliente])
      get :index
      assigns[:historico_clientes].should == [mock_historico_cliente]
    end
  end

  describe "GET show" do
    it "assigns the requested historico_cliente as @historico_cliente" do
      HistoricoCliente.stub!(:find).with("37").and_return(mock_historico_cliente)
      get :show, :id => "37"
      assigns[:historico_cliente].should equal(mock_historico_cliente)
    end
  end

  describe "GET new" do
    it "assigns a new historico_cliente as @historico_cliente" do
      HistoricoCliente.stub!(:new).and_return(mock_historico_cliente)
      get :new
      assigns[:historico_cliente].should equal(mock_historico_cliente)
    end
  end

  describe "GET edit" do
    it "assigns the requested historico_cliente as @historico_cliente" do
      HistoricoCliente.stub!(:find).with("37").and_return(mock_historico_cliente)
      get :edit, :id => "37"
      assigns[:historico_cliente].should equal(mock_historico_cliente)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created historico_cliente as @historico_cliente" do
        HistoricoCliente.stub!(:new).with({'these' => 'params'}).and_return(mock_historico_cliente(:save => true))
        post :create, :historico_cliente => {:these => 'params'}
        assigns[:historico_cliente].should equal(mock_historico_cliente)
      end

      it "redirects to the created historico_cliente" do
        HistoricoCliente.stub!(:new).and_return(mock_historico_cliente(:save => true))
        post :create, :historico_cliente => {}
        response.should redirect_to(historico_cliente_url(mock_historico_cliente))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved historico_cliente as @historico_cliente" do
        HistoricoCliente.stub!(:new).with({'these' => 'params'}).and_return(mock_historico_cliente(:save => false))
        post :create, :historico_cliente => {:these => 'params'}
        assigns[:historico_cliente].should equal(mock_historico_cliente)
      end

      it "re-renders the 'new' template" do
        HistoricoCliente.stub!(:new).and_return(mock_historico_cliente(:save => false))
        post :create, :historico_cliente => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested historico_cliente" do
        HistoricoCliente.should_receive(:find).with("37").and_return(mock_historico_cliente)
        mock_historico_cliente.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :historico_cliente => {:these => 'params'}
      end

      it "assigns the requested historico_cliente as @historico_cliente" do
        HistoricoCliente.stub!(:find).and_return(mock_historico_cliente(:update_attributes => true))
        put :update, :id => "1"
        assigns[:historico_cliente].should equal(mock_historico_cliente)
      end

      it "redirects to the historico_cliente" do
        HistoricoCliente.stub!(:find).and_return(mock_historico_cliente(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(historico_cliente_url(mock_historico_cliente))
      end
    end

    describe "with invalid params" do
      it "updates the requested historico_cliente" do
        HistoricoCliente.should_receive(:find).with("37").and_return(mock_historico_cliente)
        mock_historico_cliente.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :historico_cliente => {:these => 'params'}
      end

      it "assigns the historico_cliente as @historico_cliente" do
        HistoricoCliente.stub!(:find).and_return(mock_historico_cliente(:update_attributes => false))
        put :update, :id => "1"
        assigns[:historico_cliente].should equal(mock_historico_cliente)
      end

      it "re-renders the 'edit' template" do
        HistoricoCliente.stub!(:find).and_return(mock_historico_cliente(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested historico_cliente" do
      HistoricoCliente.should_receive(:find).with("37").and_return(mock_historico_cliente)
      mock_historico_cliente.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the historico_clientes list" do
      HistoricoCliente.stub!(:find).and_return(mock_historico_cliente(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(historico_clientes_url)
    end
  end

end
