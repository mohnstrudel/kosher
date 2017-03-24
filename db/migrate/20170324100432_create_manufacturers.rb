class CreateManufacturers < ActiveRecord::Migration[5.0]
  def change
    create_table :manufacturers do |t|
      t.string :title
      t.text :description
      t.string :logo
      t.integer :parent_id

      t.timestamps
    end
  end
end
