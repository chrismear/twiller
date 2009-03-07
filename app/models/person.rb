require 'digest/sha1'

class Person < ActiveRecord::Base
  validates_presence_of :login
  validates_uniqueness_of :login
  
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  def self.authenticate(login, password)
    user = find_by_login(login)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.crypted_password != expected_password
        user = nil
      end
    end
    user
  end
  
  def password
    @password
  end
  
  def password=(new_password)
    @password = new_password
    return if new_password.blank?
    generate_salt
    self.crypted_password = Person.encrypted_password(password, salt)
  end
  
private
  
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.encrypted_password(password, salt)
    Digest::SHA1.hexdigest(password + salt)
  end
end
