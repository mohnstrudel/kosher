class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :logo

      t.timestamps
    end
  end
end
