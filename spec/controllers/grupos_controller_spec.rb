require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GruposController do

  def mock_grupo(stubs={})
    @mock_grupo ||= mock_model(Grupo, stubs)
  end

  describe "GET index" do
    it "assigns all grupos as @grupos" do
      Grupo.stub!(:find).with(:all).and_return([mock_grupo])
      get :index
      assigns[:grupos].should == [mock_grupo]
    end
  end

  describe "GET show" do
    it "assigns the requested grupo as @grupo" do
      Grupo.stub!(:find).with("37").and_return(mock_grupo)
      get :show, :id => "37"
      assigns[:grupo].should equal(mock_grupo)
    end
  end

  describe "GET new" do
    it "assigns a new grupo as @grupo" do
      Grupo.stub!(:new).and_return(mock_grupo)
      get :new
      assigns[:grupo].should equal(mock_grupo)
    end
  end

  describe "GET edit" do
    it "assigns the requested grupo as @grupo" do
      Grupo.stub!(:find).with("37").and_return(mock_grupo)
      get :edit, :id => "37"
      assigns[:grupo].should equal(mock_grupo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created grupo as @grupo" do
        Grupo.stub!(:new).with({'these' => 'params'}).and_return(mock_grupo(:save => true))
        post :create, :grupo => {:these => 'params'}
        assigns[:grupo].should equal(mock_grupo)
      end

      it "redirects to the created grupo" do
        Grupo.stub!(:new).and_return(mock_grupo(:save => true))
        post :create, :grupo => {}
        response.should redirect_to(grupo_url(mock_grupo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved grupo as @grupo" do
        Grupo.stub!(:new).with({'these' => 'params'}).and_return(mock_grupo(:save => false))
        post :create, :grupo => {:these => 'params'}
        assigns[:grupo].should equal(mock_grupo)
      end

      it "re-renders the 'new' template" do
        Grupo.stub!(:new).and_return(mock_grupo(:save => false))
        post :create, :grupo => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested grupo" do
        Grupo.should_receive(:find).with("37").and_return(mock_grupo)
        mock_grupo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :grupo => {:these => 'params'}
      end

      it "assigns the requested grupo as @grupo" do
        Grupo.stub!(:find).and_return(mock_grupo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:grupo].should equal(mock_grupo)
      end

      it "redirects to the grupo" do
        Grupo.stub!(:find).and_return(mock_grupo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(grupo_url(mock_grupo))
      end
    end

    describe "with invalid params" do
      it "updates the requested grupo" do
        Grupo.should_receive(:find).with("37").and_return(mock_grupo)
        mock_grupo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :grupo => {:these => 'params'}
      end

      it "assigns the grupo as @grupo" do
        Grupo.stub!(:find).and_return(mock_grupo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:grupo].should equal(mock_grupo)
      end

      it "re-renders the 'edit' template" do
        Grupo.stub!(:find).and_return(mock_grupo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested grupo" do
      Grupo.should_receive(:find).with("37").and_return(mock_grupo)
      mock_grupo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the grupos list" do
      Grupo.stub!(:find).and_return(mock_grupo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(grupos_url)
    end
  end

end
