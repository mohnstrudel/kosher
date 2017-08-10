class CreateProductBarcodes < ActiveRecord::Migration[5.1]
  def change
    create_table :product_barcodes do |t|
      t.belongs_to :barcode, foreign_key: true
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
