class RemoveEmailConfirmFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :email_confirmed
    remove_column :users, :confirm_token
  end
end
