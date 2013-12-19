class AddResetPasswordTokenAndUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :password_reset_token, :string
    
    add_index :users, :username, :unique => true
    add_index :users, :password_reset_token, :unique => true
  end
end
