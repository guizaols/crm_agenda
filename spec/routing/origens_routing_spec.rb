require 'spec_helper'

describe OrigensController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/origens" }.should route_to(:controller => "origens", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/origens/new" }.should route_to(:controller => "origens", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/origens/1" }.should route_to(:controller => "origens", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/origens/1/edit" }.should route_to(:controller => "origens", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/origens" }.should route_to(:controller => "origens", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/origens/1" }.should route_to(:controller => "origens", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/origens/1" }.should route_to(:controller => "origens", :action => "destroy", :id => "1") 
    end
  end
end
