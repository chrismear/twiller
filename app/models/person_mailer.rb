class PersonMailer < ActionMailer::Base
  def signup_notification(person)
    setup_email(person)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://YOURSITE/activate/#{person.activation_code}"
  
  end
  
  def activation(person)
    setup_email(person)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://YOURSITE/"
  end
  
  protected
    def setup_email(person)
      @recipients  = "#{person.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:person] = person
    end
end
