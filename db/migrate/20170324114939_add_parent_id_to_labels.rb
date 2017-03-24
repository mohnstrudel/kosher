class AddParentIdToLabels < ActiveRecord::Migration[5.0]
  def change
    add_column :labels, :parent_id, :integer
  end
end
