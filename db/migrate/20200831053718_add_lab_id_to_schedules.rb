class AddLabIdToSchedules < ActiveRecord::Migration[6.0]
  def change
  	 add_column :schedules, :laboratory_id, :integer
  end
end
