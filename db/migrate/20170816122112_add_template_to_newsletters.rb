class AddTemplateToNewsletters < ActiveRecord::Migration[5.1]
  def change
    add_column :newsletters, :template_id, :string
  end
end
