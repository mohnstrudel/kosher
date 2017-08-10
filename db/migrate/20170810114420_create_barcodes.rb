class CreateBarcodes < ActiveRecord::Migration[5.1]
  def change
    create_table :barcodes do |t|
      t.string :value

      t.timestamps
    end
  end
end
