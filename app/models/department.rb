class Department < ApplicationRecord
  has_many :users

  MAX_STUDENTS = 8

  def students_in
  	Schedule.where(user_id: self.users.where(department_id: self.id, is_student: true), work_date: Date.today, out: nil).where.not(in: nil)
  end
end
