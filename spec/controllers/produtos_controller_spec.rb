require 'spec_helper'

describe ProdutosController do

  def mock_produto(stubs={})
    @mock_produto ||= mock_model(Produto, stubs)
  end

  describe "GET index" do
    it "assigns all produtos as @produtos" do
      Produto.stub(:find).with(:all).and_return([mock_produto])
      get :index
      assigns[:produtos].should == [mock_produto]
    end
  end

  describe "GET show" do
    it "assigns the requested produto as @produto" do
      Produto.stub(:find).with("37").and_return(mock_produto)
      get :show, :id => "37"
      assigns[:produto].should equal(mock_produto)
    end
  end

  describe "GET new" do
    it "assigns a new produto as @produto" do
      Produto.stub(:new).and_return(mock_produto)
      get :new
      assigns[:produto].should equal(mock_produto)
    end
  end

  describe "GET edit" do
    it "assigns the requested produto as @produto" do
      Produto.stub(:find).with("37").and_return(mock_produto)
      get :edit, :id => "37"
      assigns[:produto].should equal(mock_produto)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created produto as @produto" do
        Produto.stub(:new).with({'these' => 'params'}).and_return(mock_produto(:save => true))
        post :create, :produto => {:these => 'params'}
        assigns[:produto].should equal(mock_produto)
      end

      it "redirects to the created produto" do
        Produto.stub(:new).and_return(mock_produto(:save => true))
        post :create, :produto => {}
        response.should redirect_to(produto_url(mock_produto))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved produto as @produto" do
        Produto.stub(:new).with({'these' => 'params'}).and_return(mock_produto(:save => false))
        post :create, :produto => {:these => 'params'}
        assigns[:produto].should equal(mock_produto)
      end

      it "re-renders the 'new' template" do
        Produto.stub(:new).and_return(mock_produto(:save => false))
        post :create, :produto => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested produto" do
        Produto.should_receive(:find).with("37").and_return(mock_produto)
        mock_produto.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :produto => {:these => 'params'}
      end

      it "assigns the requested produto as @produto" do
        Produto.stub(:find).and_return(mock_produto(:update_attributes => true))
        put :update, :id => "1"
        assigns[:produto].should equal(mock_produto)
      end

      it "redirects to the produto" do
        Produto.stub(:find).and_return(mock_produto(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(produto_url(mock_produto))
      end
    end

    describe "with invalid params" do
      it "updates the requested produto" do
        Produto.should_receive(:find).with("37").and_return(mock_produto)
        mock_produto.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :produto => {:these => 'params'}
      end

      it "assigns the produto as @produto" do
        Produto.stub(:find).and_return(mock_produto(:update_attributes => false))
        put :update, :id => "1"
        assigns[:produto].should equal(mock_produto)
      end

      it "re-renders the 'edit' template" do
        Produto.stub(:find).and_return(mock_produto(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested produto" do
      Produto.should_receive(:find).with("37").and_return(mock_produto)
      mock_produto.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the produtos list" do
      Produto.stub(:find).and_return(mock_produto(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(produtos_url)
    end
  end

end
