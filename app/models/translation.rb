class Translation < ApplicationRecord
  belongs_to :glossary, optional: true

  validates :source_text, presence: true, length: { maximum: 5000 }
  validates :source_language_code, inclusion: { in: Language.all_codes, message: 'Must be a valid language code.' }
  validates :target_language_code, inclusion: { in: Language.all_codes, message: 'Must be a valid language code.' }

  after_validation do
    if glossary.present? &&
       (glossary.source_language_code != source_language_code || glossary.target_language_code != target_language_code)
      errors.add(:base, 'Source language code must match that of the glossary.')
    end
  end

  def matching_terms
    return [] if glossary.blank? || glossary.terms.blank?

    glossary.terms.pluck(:source_term).map do |term|
      {
        source_text: source_text,
        glossary_term: term,
        highlighted_source_text: source_text.gsub(term, "<HIGHLIGHT>#{term}</HIGHLIGHT>")
      }
    end
  end
end
