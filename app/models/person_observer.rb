class PersonObserver < ActiveRecord::Observer
  def after_create(person)
    PersonMailer.deliver_signup_notification(person)
  end

  def after_save(person)
  
    PersonMailer.deliver_activation(person) if person.recently_activated?
  
  end
end
