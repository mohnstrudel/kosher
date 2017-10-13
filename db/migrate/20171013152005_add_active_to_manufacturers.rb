class AddActiveToManufacturers < ActiveRecord::Migration[5.1]
  def change
    add_column :manufacturers, :active, :boolean
  end
end
