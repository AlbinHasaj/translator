class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.text :source_text
      t.string :source_language_code
      t.string :target_language_code
      t.references :glossary, null: true, foreign_key: true

      t.timestamps
    end
  end
end
