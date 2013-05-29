require 'spec_helper'

describe CategoriasController do

  def mock_categoria(stubs={})
    @mock_categoria ||= mock_model(Categoria, stubs)
  end

  describe "GET index" do
    it "assigns all categorias as @categorias" do
      Categoria.stub!(:find).with(:all).and_return([mock_categoria])
      get :index
      assigns[:categorias].should == [mock_categoria]
    end
  end

  describe "GET show" do
    it "assigns the requested categoria as @categoria" do
      Categoria.stub!(:find).with("37").and_return(mock_categoria)
      get :show, :id => "37"
      assigns[:categoria].should equal(mock_categoria)
    end
  end

  describe "GET new" do
    it "assigns a new categoria as @categoria" do
      Categoria.stub!(:new).and_return(mock_categoria)
      get :new
      assigns[:categoria].should equal(mock_categoria)
    end
  end

  describe "GET edit" do
    it "assigns the requested categoria as @categoria" do
      Categoria.stub!(:find).with("37").and_return(mock_categoria)
      get :edit, :id => "37"
      assigns[:categoria].should equal(mock_categoria)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created categoria as @categoria" do
        Categoria.stub!(:new).with({'these' => 'params'}).and_return(mock_categoria(:save => true))
        post :create, :categoria => {:these => 'params'}
        assigns[:categoria].should equal(mock_categoria)
      end

      it "redirects to the created categoria" do
        Categoria.stub!(:new).and_return(mock_categoria(:save => true))
        post :create, :categoria => {}
        response.should redirect_to(categoria_url(mock_categoria))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved categoria as @categoria" do
        Categoria.stub!(:new).with({'these' => 'params'}).and_return(mock_categoria(:save => false))
        post :create, :categoria => {:these => 'params'}
        assigns[:categoria].should equal(mock_categoria)
      end

      it "re-renders the 'new' template" do
        Categoria.stub!(:new).and_return(mock_categoria(:save => false))
        post :create, :categoria => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested categoria" do
        Categoria.should_receive(:find).with("37").and_return(mock_categoria)
        mock_categoria.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :categoria => {:these => 'params'}
      end

      it "assigns the requested categoria as @categoria" do
        Categoria.stub!(:find).and_return(mock_categoria(:update_attributes => true))
        put :update, :id => "1"
        assigns[:categoria].should equal(mock_categoria)
      end

      it "redirects to the categoria" do
        Categoria.stub!(:find).and_return(mock_categoria(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(categoria_url(mock_categoria))
      end
    end

    describe "with invalid params" do
      it "updates the requested categoria" do
        Categoria.should_receive(:find).with("37").and_return(mock_categoria)
        mock_categoria.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :categoria => {:these => 'params'}
      end

      it "assigns the categoria as @categoria" do
        Categoria.stub!(:find).and_return(mock_categoria(:update_attributes => false))
        put :update, :id => "1"
        assigns[:categoria].should equal(mock_categoria)
      end

      it "re-renders the 'edit' template" do
        Categoria.stub!(:find).and_return(mock_categoria(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested categoria" do
      Categoria.should_receive(:find).with("37").and_return(mock_categoria)
      mock_categoria.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the categorias list" do
      Categoria.stub!(:find).and_return(mock_categoria(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(categorias_url)
    end
  end

end
