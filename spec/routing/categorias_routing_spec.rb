require 'spec_helper'

describe CategoriasController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/categorias" }.should route_to(:controller => "categorias", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/categorias/new" }.should route_to(:controller => "categorias", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/categorias/1" }.should route_to(:controller => "categorias", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/categorias/1/edit" }.should route_to(:controller => "categorias", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/categorias" }.should route_to(:controller => "categorias", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/categorias/1" }.should route_to(:controller => "categorias", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/categorias/1" }.should route_to(:controller => "categorias", :action => "destroy", :id => "1") 
    end
  end
end
