class AddFieldsToGeneralSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :general_settings, :address, :text
    add_column :general_settings, :opening_hours, :hstore
  end
end
