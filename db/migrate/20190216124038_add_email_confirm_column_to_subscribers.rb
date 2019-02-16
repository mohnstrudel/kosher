class AddEmailConfirmColumnToSubscribers < ActiveRecord::Migration[5.2]
  def change
    add_column :subscribers, :email_confirmed, :boolean, default: false
    add_column :subscribers, :confirm_token, :string
  end
end
