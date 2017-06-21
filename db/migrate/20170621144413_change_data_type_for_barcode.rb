class ChangeDataTypeForBarcode < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :barcode, :bigint
  end
end
