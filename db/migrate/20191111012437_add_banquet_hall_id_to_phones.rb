class AddBanquetHallIdToPhones < ActiveRecord::Migration[5.2]
  def change
    add_reference :phones, :banquet_hall, foreign_key: true
  end
end
