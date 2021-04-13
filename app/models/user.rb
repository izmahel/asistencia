class User < ApplicationRecord
  belongs_to :department
  belongs_to :location
  has_many :supervisors, :foreign_key => "student_id", :class_name => "StudentSupervisor"
  has_many :student_supervisor
  ACTIVE = 1
  INACTIVE = 2

  MAX_PER_LAB = 2

  def fullname 
  	first_name + ' ' + last_name
  end

  def shortname 
    self.email.split('@')[0] rescue 'Email Invalido'
  end

  def display_url
    "https://cimav.edu.mx/foto/#{self.shortname}/256"
  end

  def is_in?
    sched = Schedule.where(user_id: self.id, work_date: Date.today, out: nil).where.not(in: nil).first rescue false
    return sched 
  end

end
