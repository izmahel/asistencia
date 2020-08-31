class CreateStudentSupervisors < ActiveRecord::Migration[6.0]
  def change
    create_table :student_supervisors do |t|
      t.references :user
      t.references :student
      t.timestamps
    end
  end
end
