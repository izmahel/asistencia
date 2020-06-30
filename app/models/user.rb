class User < ApplicationRecord
  belongs_to :department
  ACTIVE = 1
  INACTIVE = 2

  def fullname 
  	first_name + ' ' + last_name
  end

  def shortname 
    self.email.split('@')[0] rescue 'Email Invalido'
  end

  def display_url
    "https://cimav.edu.mx/foto/#{self.shortname}/256"
  end
end
