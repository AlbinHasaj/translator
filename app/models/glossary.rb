class Glossary < ApplicationRecord
  validates :source_language_code, inclusion: { in: Language.all_codes, message: 'Must be a valid language code.' },
                                   uniqueness: { scope: :target_language_code, message: 'Glossary already exists.' }
  validates :target_language_code, inclusion: { in: Language.all_codes, message: 'Must be a valid language code.' }

  has_many :terms, dependent: :destroy
  has_many :translations, dependent: :destroy
end
