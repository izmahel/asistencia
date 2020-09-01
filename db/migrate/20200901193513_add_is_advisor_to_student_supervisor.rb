class AddIsAdvisorToStudentSupervisor < ActiveRecord::Migration[6.0]
  def change
  	add_column :student_supervisors, :is_advisor, :boolean
  end
end
