class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :company_name
      t.string :email
      t.string :phone
      t.string :message
      t.string :type
      t.string :subject

      t.timestamps
    end
  end
end
