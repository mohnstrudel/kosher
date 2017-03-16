class AddRestaurantReferenceToOpeningHours < ActiveRecord::Migration[5.0]
  def change
    add_reference :opening_hours, :restaurant, foreign_key: true
  end
end
