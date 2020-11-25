class AddLocationToDepartments < ActiveRecord::Migration[6.0]
  def change
  	add_column :departments, :location_id, :integer
  end
end
