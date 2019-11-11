class AddBanquetHallIdToOpeningHours < ActiveRecord::Migration[5.2]
  def change
    add_reference :opening_hours, :banquet_hall, foreign_key: true
  end
end
