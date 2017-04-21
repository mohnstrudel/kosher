class DropOldTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :sublabels
    drop_table :kosher_ltwo_labels
    drop_table :kosher_lone_labels
  end
end
