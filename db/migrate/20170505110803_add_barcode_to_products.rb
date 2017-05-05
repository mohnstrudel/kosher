class AddBarcodeToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :barcode, :integer
  end
end
