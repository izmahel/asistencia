class AddTemperatureToSchedules < ActiveRecord::Migration[6.0]
  def change
  	add_column :schedules, :temperature, :string
  end
end
