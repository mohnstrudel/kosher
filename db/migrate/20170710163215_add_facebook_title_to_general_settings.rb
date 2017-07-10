class AddFacebookTitleToGeneralSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :general_settings, :facebook, :string
    add_column :general_settings, :title, :string
  end
end
