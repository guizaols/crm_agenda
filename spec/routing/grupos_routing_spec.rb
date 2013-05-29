require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GruposController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "grupos", :action => "index").should == "/grupos"
    end

    it "maps #new" do
      route_for(:controller => "grupos", :action => "new").should == "/grupos/new"
    end

    it "maps #show" do
      route_for(:controller => "grupos", :action => "show", :id => "1").should == "/grupos/1"
    end

    it "maps #edit" do
      route_for(:controller => "grupos", :action => "edit", :id => "1").should == "/grupos/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "grupos", :action => "create").should == {:path => "/grupos", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "grupos", :action => "update", :id => "1").should == {:path =>"/grupos/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "grupos", :action => "destroy", :id => "1").should == {:path =>"/grupos/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/grupos").should == {:controller => "grupos", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/grupos/new").should == {:controller => "grupos", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/grupos").should == {:controller => "grupos", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/grupos/1").should == {:controller => "grupos", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/grupos/1/edit").should == {:controller => "grupos", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/grupos/1").should == {:controller => "grupos", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/grupos/1").should == {:controller => "grupos", :action => "destroy", :id => "1"}
    end
  end
end
