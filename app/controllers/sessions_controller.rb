class SessionsController < ApplicationController
  def new
  end

  def create
    @person = Person.authenticate(params[:login], params[:password])
    if @person
      self.current_person = @person
      flash[:success] = "Logged in successfully."
      redirect_back_or_default(home_path)
    else
      flash[:error] = "There was a problem with your login details."
      render(:action => :new)
    end
  end

  def destroy
    self.current_person = :false
    flash[:success] = "Logged out successfully."
    redirect_back_or_default(home_path)
  end
end
