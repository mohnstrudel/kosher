class Barcode < ApplicationRecord
  has_many :product_barcodes
  has_many :products, through: :product_barcodes
end
