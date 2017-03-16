class AddEmailToGeneralSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :general_settings, :email, :string
  end
end
