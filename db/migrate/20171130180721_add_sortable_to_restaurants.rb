class AddSortableToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :sortable, :integer
  end
end
