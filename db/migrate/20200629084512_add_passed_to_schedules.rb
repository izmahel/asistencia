class AddPassedToSchedules < ActiveRecord::Migration[6.0]
  def change
  	add_column :schedules, :passed, :boolean
  end
end
