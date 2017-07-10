class RemoveTypeFromRequests < ActiveRecord::Migration[5.1]
  def change
    remove_column :requests, :type
  end
end
