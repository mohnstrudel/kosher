class AddTypeToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :type, :string
  end
end
