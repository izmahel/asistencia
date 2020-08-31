class AddStartEndToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :start, :integer
    add_column :schedules, :end, :integer
  end
end
