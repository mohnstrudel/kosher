class GlobalizeGemMigrateGeneralSettings < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        GeneralSetting.create_translation_table!({
                                           :address => :text
                                       }, {
                                           :migrate_data => true
                                       })
      end

      dir.down do
        GeneralSetting.drop_translation_table! :migrate_data => true
      end
    end
  end
end