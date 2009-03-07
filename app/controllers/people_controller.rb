class PeopleController < ApplicationController
  def new
  end
  
  def create
    @person = Person.new(params[:person])
    if @person.save
      self.current_person = @person
      flash[:success] = "Thanks for signing up!"
      redirect_to(home_path)
    else
      flash[:error] = "Sorry, there was a problem with your details."
      render(:action => :new)
    end
  end
end
