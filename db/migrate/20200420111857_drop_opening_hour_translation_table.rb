class DropOpeningHourTranslationTable < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        OpeningHour.drop_translation_table! :migrate_data => true
      end
    end
  end
end