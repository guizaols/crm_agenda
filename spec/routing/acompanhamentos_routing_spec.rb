require 'spec_helper'

describe AcompanhamentosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/acompanhamentos" }.should route_to(:controller => "acompanhamentos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/acompanhamentos/new" }.should route_to(:controller => "acompanhamentos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/acompanhamentos/1" }.should route_to(:controller => "acompanhamentos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/acompanhamentos/1/edit" }.should route_to(:controller => "acompanhamentos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/acompanhamentos" }.should route_to(:controller => "acompanhamentos", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/acompanhamentos/1" }.should route_to(:controller => "acompanhamentos", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/acompanhamentos/1" }.should route_to(:controller => "acompanhamentos", :action => "destroy", :id => "1") 
    end
  end
end
