class AddActivenessToLabels < ActiveRecord::Migration[5.1]
  def change
    add_column :labels, :active, :boolean
  end
end
