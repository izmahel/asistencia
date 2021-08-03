class AddGroupLevelToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :rh_group, :string
    add_column :users, :rh_level, :string
    add_column :users, :rh_id, :string
  end
end
