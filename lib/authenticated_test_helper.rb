module AuthenticatedTestHelper
  # Sets the current person in the session from the person fixtures.
  def login_as(person)
    @request.session[:person_id] = person ? people(person).id : nil
  end

  def authorize_as(person)
    @request.env["HTTP_AUTHORIZATION"] = person ? ActionController::HttpAuthentication::Basic.encode_credentials(people(person).login, 'monkey') : nil
  end
  
  # rspec
  def mock_person
    person = mock_model(Person, :id => 1,
      :login  => 'user_name',
      :name   => 'U. Surname',
      :to_xml => "Person-in-XML", :to_json => "Person-in-JSON", 
      :errors => [])
    person
  end  
end

REST_AUTH_SITE_KEY         = 'b048052245c915d3ca8e114307f3da8b50ef7eb4'
