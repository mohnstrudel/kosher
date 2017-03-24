class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.belongs_to :category, foreign_key: true
      t.belongs_to :label, foreign_key: true
      t.belongs_to :manufacturer, foreign_key: true
      t.string :title
      t.string :description
      t.string :logo

      t.timestamps
    end
  end
end
