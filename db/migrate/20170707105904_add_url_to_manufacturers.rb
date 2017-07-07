class AddUrlToManufacturers < ActiveRecord::Migration[5.1]
  def change
    add_column :manufacturers, :url, :string
  end
end
