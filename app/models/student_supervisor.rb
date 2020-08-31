class StudentSupervisor < ApplicationRecord
  belongs_to :user
  belongs_to :student, :foreign_key => "student_id", :class_name => "User"
end
