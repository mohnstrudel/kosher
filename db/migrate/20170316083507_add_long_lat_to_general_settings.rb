class AddLongLatToGeneralSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :general_settings, :long, :float
    add_column :general_settings, :lat, :float
  end
end
