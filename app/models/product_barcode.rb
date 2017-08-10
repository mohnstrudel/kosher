class ProductBarcode < ApplicationRecord
  belongs_to :barcode, optional: true
  belongs_to :product, optional: true
end
