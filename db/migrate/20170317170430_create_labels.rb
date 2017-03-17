class CreateLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :labels do |t|
      t.string :logo
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
