class AddPasswordTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_password, :timestamp
  end
end
