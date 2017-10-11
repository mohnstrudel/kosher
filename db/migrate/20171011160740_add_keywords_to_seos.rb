class AddKeywordsToSeos < ActiveRecord::Migration[5.1]
  def change
    add_column :seos, :keywords, :string, array: true, default: []
  end
end
