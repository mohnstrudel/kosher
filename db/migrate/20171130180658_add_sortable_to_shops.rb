class AddSortableToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :sortable, :integer
  end
end
