require 'spec_helper'

describe TipoCompromissosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/tipo_compromissos" }.should route_to(:controller => "tipo_compromissos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/tipo_compromissos/new" }.should route_to(:controller => "tipo_compromissos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/tipo_compromissos/1" }.should route_to(:controller => "tipo_compromissos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/tipo_compromissos/1/edit" }.should route_to(:controller => "tipo_compromissos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/tipo_compromissos" }.should route_to(:controller => "tipo_compromissos", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/tipo_compromissos/1" }.should route_to(:controller => "tipo_compromissos", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/tipo_compromissos/1" }.should route_to(:controller => "tipo_compromissos", :action => "destroy", :id => "1") 
    end
  end
end
