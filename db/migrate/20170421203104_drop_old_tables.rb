class DropOldTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :sublabels, if_exists: true
    drop_table :kosher_ltwo_labels, if_exists: true
    drop_table :kosher_lone_labels, if_exists: true
  end
end
