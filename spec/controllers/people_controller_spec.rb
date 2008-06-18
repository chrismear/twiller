require File.dirname(__FILE__) + '/../spec_helper'
  
# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe PeopleController do
  fixtures :people

  it 'allows signup' do
    lambda do
      create_person
      response.should be_redirect
    end.should change(Person, :count).by(1)
  end

  
  it 'signs up user in pending state' do
    create_person
    assigns(:person).reload
    assigns(:person).should be_pending
  end

  it 'signs up user with activation code' do
    create_person
    assigns(:person).reload
    assigns(:person).activation_code.should_not be_nil
  end
  it 'requires login on signup' do
    lambda do
      create_person(:login => nil)
      assigns[:person].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Person, :count)
  end
  
  it 'requires password on signup' do
    lambda do
      create_person(:password => nil)
      assigns[:person].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Person, :count)
  end
  
  it 'requires password confirmation on signup' do
    lambda do
      create_person(:password_confirmation => nil)
      assigns[:person].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Person, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_person(:email => nil)
      assigns[:person].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Person, :count)
  end
  
  
  it 'activates user' do
    Person.authenticate('aaron', 'monkey').should be_nil
    get :activate, :activation_code => people(:aaron).activation_code
    response.should redirect_to('/login')
    flash[:notice].should_not be_nil
    flash[:error ].should     be_nil
    Person.authenticate('aaron', 'monkey').should == people(:aaron)
  end
  
  it 'does not activate user without key' do
    get :activate
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  it 'does not activate user with blank key' do
    get :activate, :activation_code => ''
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  it 'does not activate user with bogus key' do
    get :activate, :activation_code => 'i_haxxor_joo'
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  def create_person(options = {})
    post :create, :person => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
  end
end

describe PeopleController do
  describe "route generation" do
    it "should route people's 'index' action correctly" do
      route_for(:controller => 'people', :action => 'index').should == "/people"
    end
    
    it "should route people's 'new' action correctly" do
      route_for(:controller => 'people', :action => 'new').should == "/signup"
    end
    
    it "should route {:controller => 'people', :action => 'create'} correctly" do
      route_for(:controller => 'people', :action => 'create').should == "/register"
    end
    
    it "should route people's 'show' action correctly" do
      route_for(:controller => 'people', :action => 'show', :id => '1').should == "/people/1"
    end
    
    it "should route people's 'edit' action correctly" do
      route_for(:controller => 'people', :action => 'edit', :id => '1').should == "/people/1/edit"
    end
    
    it "should route people's 'update' action correctly" do
      route_for(:controller => 'people', :action => 'update', :id => '1').should == "/people/1"
    end
    
    it "should route people's 'destroy' action correctly" do
      route_for(:controller => 'people', :action => 'destroy', :id => '1').should == "/people/1"
    end
  end
  
  describe "route recognition" do
    it "should generate params for people's index action from GET /people" do
      params_from(:get, '/people').should == {:controller => 'people', :action => 'index'}
      params_from(:get, '/people.xml').should == {:controller => 'people', :action => 'index', :format => 'xml'}
      params_from(:get, '/people.json').should == {:controller => 'people', :action => 'index', :format => 'json'}
    end
    
    it "should generate params for people's new action from GET /people" do
      params_from(:get, '/people/new').should == {:controller => 'people', :action => 'new'}
      params_from(:get, '/people/new.xml').should == {:controller => 'people', :action => 'new', :format => 'xml'}
      params_from(:get, '/people/new.json').should == {:controller => 'people', :action => 'new', :format => 'json'}
    end
    
    it "should generate params for people's create action from POST /people" do
      params_from(:post, '/people').should == {:controller => 'people', :action => 'create'}
      params_from(:post, '/people.xml').should == {:controller => 'people', :action => 'create', :format => 'xml'}
      params_from(:post, '/people.json').should == {:controller => 'people', :action => 'create', :format => 'json'}
    end
    
    it "should generate params for people's show action from GET /people/1" do
      params_from(:get , '/people/1').should == {:controller => 'people', :action => 'show', :id => '1'}
      params_from(:get , '/people/1.xml').should == {:controller => 'people', :action => 'show', :id => '1', :format => 'xml'}
      params_from(:get , '/people/1.json').should == {:controller => 'people', :action => 'show', :id => '1', :format => 'json'}
    end
    
    it "should generate params for people's edit action from GET /people/1/edit" do
      params_from(:get , '/people/1/edit').should == {:controller => 'people', :action => 'edit', :id => '1'}
    end
    
    it "should generate params {:controller => 'people', :action => update', :id => '1'} from PUT /people/1" do
      params_from(:put , '/people/1').should == {:controller => 'people', :action => 'update', :id => '1'}
      params_from(:put , '/people/1.xml').should == {:controller => 'people', :action => 'update', :id => '1', :format => 'xml'}
      params_from(:put , '/people/1.json').should == {:controller => 'people', :action => 'update', :id => '1', :format => 'json'}
    end
    
    it "should generate params for people's destroy action from DELETE /people/1" do
      params_from(:delete, '/people/1').should == {:controller => 'people', :action => 'destroy', :id => '1'}
      params_from(:delete, '/people/1.xml').should == {:controller => 'people', :action => 'destroy', :id => '1', :format => 'xml'}
      params_from(:delete, '/people/1.json').should == {:controller => 'people', :action => 'destroy', :id => '1', :format => 'json'}
    end
  end
  
  describe "named routing" do
    before(:each) do
      get :new
    end
    
    it "should route people_path() to /people" do
      people_path().should == "/people"
      formatted_people_path(:format => 'xml').should == "/people.xml"
      formatted_people_path(:format => 'json').should == "/people.json"
    end
    
    it "should route new_person_path() to /people/new" do
      new_person_path().should == "/people/new"
      formatted_new_person_path(:format => 'xml').should == "/people/new.xml"
      formatted_new_person_path(:format => 'json').should == "/people/new.json"
    end
    
    it "should route person_(:id => '1') to /people/1" do
      person_path(:id => '1').should == "/people/1"
      formatted_person_path(:id => '1', :format => 'xml').should == "/people/1.xml"
      formatted_person_path(:id => '1', :format => 'json').should == "/people/1.json"
    end
    
    it "should route edit_person_path(:id => '1') to /people/1/edit" do
      edit_person_path(:id => '1').should == "/people/1/edit"
    end
  end
  
end
