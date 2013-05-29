require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RetiradasController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "retiradas", :action => "index").should == "/retiradas"
    end

    it "maps #new" do
      route_for(:controller => "retiradas", :action => "new").should == "/retiradas/new"
    end

    it "maps #show" do
      route_for(:controller => "retiradas", :action => "show", :id => "1").should == "/retiradas/1"
    end

    it "maps #edit" do
      route_for(:controller => "retiradas", :action => "edit", :id => "1").should == "/retiradas/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "retiradas", :action => "create").should == {:path => "/retiradas", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "retiradas", :action => "update", :id => "1").should == {:path =>"/retiradas/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "retiradas", :action => "destroy", :id => "1").should == {:path =>"/retiradas/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/retiradas").should == {:controller => "retiradas", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/retiradas/new").should == {:controller => "retiradas", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/retiradas").should == {:controller => "retiradas", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/retiradas/1").should == {:controller => "retiradas", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/retiradas/1/edit").should == {:controller => "retiradas", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/retiradas/1").should == {:controller => "retiradas", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/retiradas/1").should == {:controller => "retiradas", :action => "destroy", :id => "1"}
    end
  end
end
