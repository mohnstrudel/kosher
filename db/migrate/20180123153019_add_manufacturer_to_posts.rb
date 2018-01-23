class AddManufacturerToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :manufacturer, foreign_key: true
  end
end
