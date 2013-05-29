require 'spec_helper'

describe AcompanhamentosController do

  def mock_acompanhamento(stubs={})
    @mock_acompanhamento ||= mock_model(Acompanhamento, stubs)
  end

  describe "GET index" do
    it "assigns all acompanhamentos as @acompanhamentos" do
      Acompanhamento.stub!(:find).with(:all).and_return([mock_acompanhamento])
      get :index
      assigns[:acompanhamentos].should == [mock_acompanhamento]
    end
  end

  describe "GET show" do
    it "assigns the requested acompanhamento as @acompanhamento" do
      Acompanhamento.stub!(:find).with("37").and_return(mock_acompanhamento)
      get :show, :id => "37"
      assigns[:acompanhamento].should equal(mock_acompanhamento)
    end
  end

  describe "GET new" do
    it "assigns a new acompanhamento as @acompanhamento" do
      Acompanhamento.stub!(:new).and_return(mock_acompanhamento)
      get :new
      assigns[:acompanhamento].should equal(mock_acompanhamento)
    end
  end

  describe "GET edit" do
    it "assigns the requested acompanhamento as @acompanhamento" do
      Acompanhamento.stub!(:find).with("37").and_return(mock_acompanhamento)
      get :edit, :id => "37"
      assigns[:acompanhamento].should equal(mock_acompanhamento)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created acompanhamento as @acompanhamento" do
        Acompanhamento.stub!(:new).with({'these' => 'params'}).and_return(mock_acompanhamento(:save => true))
        post :create, :acompanhamento => {:these => 'params'}
        assigns[:acompanhamento].should equal(mock_acompanhamento)
      end

      it "redirects to the created acompanhamento" do
        Acompanhamento.stub!(:new).and_return(mock_acompanhamento(:save => true))
        post :create, :acompanhamento => {}
        response.should redirect_to(acompanhamento_url(mock_acompanhamento))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved acompanhamento as @acompanhamento" do
        Acompanhamento.stub!(:new).with({'these' => 'params'}).and_return(mock_acompanhamento(:save => false))
        post :create, :acompanhamento => {:these => 'params'}
        assigns[:acompanhamento].should equal(mock_acompanhamento)
      end

      it "re-renders the 'new' template" do
        Acompanhamento.stub!(:new).and_return(mock_acompanhamento(:save => false))
        post :create, :acompanhamento => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested acompanhamento" do
        Acompanhamento.should_receive(:find).with("37").and_return(mock_acompanhamento)
        mock_acompanhamento.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :acompanhamento => {:these => 'params'}
      end

      it "assigns the requested acompanhamento as @acompanhamento" do
        Acompanhamento.stub!(:find).and_return(mock_acompanhamento(:update_attributes => true))
        put :update, :id => "1"
        assigns[:acompanhamento].should equal(mock_acompanhamento)
      end

      it "redirects to the acompanhamento" do
        Acompanhamento.stub!(:find).and_return(mock_acompanhamento(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(acompanhamento_url(mock_acompanhamento))
      end
    end

    describe "with invalid params" do
      it "updates the requested acompanhamento" do
        Acompanhamento.should_receive(:find).with("37").and_return(mock_acompanhamento)
        mock_acompanhamento.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :acompanhamento => {:these => 'params'}
      end

      it "assigns the acompanhamento as @acompanhamento" do
        Acompanhamento.stub!(:find).and_return(mock_acompanhamento(:update_attributes => false))
        put :update, :id => "1"
        assigns[:acompanhamento].should equal(mock_acompanhamento)
      end

      it "re-renders the 'edit' template" do
        Acompanhamento.stub!(:find).and_return(mock_acompanhamento(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested acompanhamento" do
      Acompanhamento.should_receive(:find).with("37").and_return(mock_acompanhamento)
      mock_acompanhamento.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the acompanhamentos list" do
      Acompanhamento.stub!(:find).and_return(mock_acompanhamento(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(acompanhamentos_url)
    end
  end

end
