class AddSortableToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :sortable, :integer
  end
end
