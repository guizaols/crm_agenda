require 'spec_helper'

describe MoedasController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/moedas" }.should route_to(:controller => "moedas", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/moedas/new" }.should route_to(:controller => "moedas", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/moedas/1" }.should route_to(:controller => "moedas", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/moedas/1/edit" }.should route_to(:controller => "moedas", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/moedas" }.should route_to(:controller => "moedas", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/moedas/1" }.should route_to(:controller => "moedas", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/moedas/1" }.should route_to(:controller => "moedas", :action => "destroy", :id => "1") 
    end
  end
end
