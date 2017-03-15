class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.string :value
      t.belongs_to :general_setting, foreign_key: true

      t.timestamps
    end
  end
end
