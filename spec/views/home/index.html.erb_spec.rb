require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/home/index" do
  describe "when not logged in" do
    before(:each) do
      render 'home/index'
    end
    
    it "should show a sign up link" do
      response.should have_tag("a[href=/signup]")
    end
    
    it "should show a log in link" do
      response.should have_tag("a[href=/login]")
    end
  end
  
  describe "when logged in" do
    before(:each) do
      @person = mock_person
      login_as(@person)
      render 'home/index'
    end
    
    it "should show a log out link" do
      response.should have_tag("a[href=/logout][onclick*=delete]")
    end
  end
end
