require 'spec_helper'

describe HistoricoClientesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/historico_clientes" }.should route_to(:controller => "historico_clientes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/historico_clientes/new" }.should route_to(:controller => "historico_clientes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/historico_clientes/1" }.should route_to(:controller => "historico_clientes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/historico_clientes/1/edit" }.should route_to(:controller => "historico_clientes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/historico_clientes" }.should route_to(:controller => "historico_clientes", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/historico_clientes/1" }.should route_to(:controller => "historico_clientes", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/historico_clientes/1" }.should route_to(:controller => "historico_clientes", :action => "destroy", :id => "1") 
    end
  end
end
