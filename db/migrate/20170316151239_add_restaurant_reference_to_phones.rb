class AddRestaurantReferenceToPhones < ActiveRecord::Migration[5.0]
  def change
    add_reference :phones, :restaurant, foreign_key: true
  end
end
