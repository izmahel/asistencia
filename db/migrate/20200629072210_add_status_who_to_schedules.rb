class AddStatusWhoToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :who, :integer
    add_column :schedules, :status, :integer
  end
end
