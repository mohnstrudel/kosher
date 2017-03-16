class AddShopReferenceToPhones < ActiveRecord::Migration[5.0]
  def change
    add_reference :phones, :shop, foreign_key: true
  end
end
