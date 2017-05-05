class AddKosherLabelToCategories < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :label, foreign_key: true
  end
end
