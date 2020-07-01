class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :admin, :boolean
  	add_column :users, :course, :boolean
  	add_column :users, :unlimited, :boolean

  end
end
