class CreateBanquetHalls < ActiveRecord::Migration[5.2]
  def change
    create_table :banquet_halls do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :logo
      t.text :address
      t.string :slug
      t.integer :sortable
      t.belongs_to :city, foreign_key: true

      t.timestamps
    end
    add_index :banquet_halls, :slug, unique: true
  end
end
