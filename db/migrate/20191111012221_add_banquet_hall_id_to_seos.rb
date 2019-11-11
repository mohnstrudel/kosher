class AddBanquetHallIdToSeos < ActiveRecord::Migration[5.2]
  def change
    add_reference :seos, :banquet_hall, foreign_key: true
  end
end
