require 'spec_helper'

describe PropostasController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/propostas" }.should route_to(:controller => "propostas", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/propostas/new" }.should route_to(:controller => "propostas", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/propostas/1" }.should route_to(:controller => "propostas", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/propostas/1/edit" }.should route_to(:controller => "propostas", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/propostas" }.should route_to(:controller => "propostas", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/propostas/1" }.should route_to(:controller => "propostas", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/propostas/1" }.should route_to(:controller => "propostas", :action => "destroy", :id => "1") 
    end
  end
end
