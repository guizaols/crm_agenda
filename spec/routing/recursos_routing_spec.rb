require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RecursosController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "recursos", :action => "index").should == "/recursos"
    end

    it "maps #new" do
      route_for(:controller => "recursos", :action => "new").should == "/recursos/new"
    end

    it "maps #show" do
      route_for(:controller => "recursos", :action => "show", :id => "1").should == "/recursos/1"
    end

    it "maps #edit" do
      route_for(:controller => "recursos", :action => "edit", :id => "1").should == "/recursos/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "recursos", :action => "create").should == {:path => "/recursos", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "recursos", :action => "update", :id => "1").should == {:path =>"/recursos/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "recursos", :action => "destroy", :id => "1").should == {:path =>"/recursos/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/recursos").should == {:controller => "recursos", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/recursos/new").should == {:controller => "recursos", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/recursos").should == {:controller => "recursos", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/recursos/1").should == {:controller => "recursos", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/recursos/1/edit").should == {:controller => "recursos", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/recursos/1").should == {:controller => "recursos", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/recursos/1").should == {:controller => "recursos", :action => "destroy", :id => "1"}
    end
  end
end
