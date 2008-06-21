require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController, "routing" do
  it "should route the index action" do
    params_from(:get, '/').should == {:controller => "home", :action => "index"}
    route_for(:controller => 'home', :action => 'index').should == '/'
  end
end

describe HomeController do
  describe "GETting index" do
  end
end
