# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9054a504e8cfd455107c37ee845ff83d'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  # Authentication
  # (Shamelessly stealing the bits of restful_authentication that I like.)
  
  def current_person=(person)
    session[:current_person_id] = (person.nil? || person.is_a?(Symbol)) ? nil : person.id
    @current_person = person
  end
  
  helper_method :current_person
  def current_person
    @current_person ||= (session[:current_person_id] && Person.find_by_id(session[:current_person_id])) || :false
  end
  
  helper_method :logged_in?
  def logged_in?
    current_person != :false
  end
  
  def login_required
    if logged_in
      true
    else
      flash[:notice] = "You must be logged-in to do that."
      store_location
      redirect_to(login_path)
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(default)
    session[:return_to] = nil
  end
end
