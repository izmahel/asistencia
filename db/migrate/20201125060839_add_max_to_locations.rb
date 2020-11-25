class AddMaxToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :max, :integer
  end
end
