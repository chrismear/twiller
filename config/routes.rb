ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy', :conditions => {:method => :delete}
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'people', :action => 'create', :conditions => {:method => :post}
  map.signup '/signup', :controller => 'people', :action => 'new'
  
  map.resources :people

  map.resource :session
  
  map.home '', :controller => 'home', :action => 'index'
end
