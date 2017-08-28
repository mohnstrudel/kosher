class CreatePartners < ActiveRecord::Migration[5.1]
  def change
    create_table :partners do |t|
      t.string :title
      t.string :logo
      t.string :logo_grey

      t.timestamps
    end
  end
end
