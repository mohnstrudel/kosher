class AddShopReferenceToOpeningHours < ActiveRecord::Migration[5.0]
  def change
    add_reference :opening_hours, :shop, foreign_key: true
  end
end
