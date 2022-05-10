class Term < ApplicationRecord
  belongs_to :glossary

  validates :source_term, presence: true
  validates :target_term, presence: true
end
