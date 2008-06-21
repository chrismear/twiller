require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper, "standard_flashes" do
  include ApplicationHelper
  
  it "should render an error flash" do
    flash[:error] = "Error message."
    standard_flashes.should == '<div class="error">Error message.</div>'
  end
  
  it "should render a notice flash" do
    flash[:notice] = "Notice."
    standard_flashes.should == '<div class="notice">Notice.</div>'
  end
  
  it "should render both an error flash and a notice flash" do
    flash[:error] = "Error message."
    flash[:notice] = "Notice."
    standard_flashes.should == '<div class="error">Error message.</div><div class="notice">Notice.</div>'
  end
end
