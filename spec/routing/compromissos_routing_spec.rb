require 'spec_helper'

describe CompromissosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/compromissos" }.should route_to(:controller => "compromissos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/compromissos/new" }.should route_to(:controller => "compromissos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/compromissos/1" }.should route_to(:controller => "compromissos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/compromissos/1/edit" }.should route_to(:controller => "compromissos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/compromissos" }.should route_to(:controller => "compromissos", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/compromissos/1" }.should route_to(:controller => "compromissos", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/compromissos/1" }.should route_to(:controller => "compromissos", :action => "destroy", :id => "1") 
    end
  end
end
