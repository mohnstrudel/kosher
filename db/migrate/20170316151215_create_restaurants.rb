class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :logo
      t.text :address

      t.timestamps
    end
  end
end
