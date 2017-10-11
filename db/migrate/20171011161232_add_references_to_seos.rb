class AddReferencesToSeos < ActiveRecord::Migration[5.1]
  def change
    add_reference :seos, :post, foreign_key: true
    add_reference :seos, :manufacturer, foreign_key: true
    add_reference :seos, :product, foreign_key: true
    add_reference :seos, :restaurant, foreign_key: true
    add_reference :seos, :shop, foreign_key: true
  end
end
