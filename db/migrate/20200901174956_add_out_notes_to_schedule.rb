class AddOutNotesToSchedule < ActiveRecord::Migration[6.0]
  def change
  	add_column :schedules, :out_notes, :string
  end
end
