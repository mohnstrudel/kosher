class CreateSublabels < ActiveRecord::Migration[5.0]
  def change
    create_table :sublabels do |t|
      t.string :logo
      t.string :title
      t.text :description
      t.belongs_to :label, foreign_key: true

      t.timestamps
    end
  end
end
