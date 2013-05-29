require 'spec_helper'

describe HistoricosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/historicos" }.should route_to(:controller => "historicos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/historicos/new" }.should route_to(:controller => "historicos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/historicos/1" }.should route_to(:controller => "historicos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/historicos/1/edit" }.should route_to(:controller => "historicos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/historicos" }.should route_to(:controller => "historicos", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/historicos/1" }.should route_to(:controller => "historicos", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/historicos/1" }.should route_to(:controller => "historicos", :action => "destroy", :id => "1") 
    end
  end
end
