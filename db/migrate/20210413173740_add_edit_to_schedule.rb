class AddEditToSchedule < ActiveRecord::Migration[6.0]
  def change
  	add_column :schedules, :edit_by, :integer
  	add_column :schedules, :edit_notes, :string
  end
end
