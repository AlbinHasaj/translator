FactoryBot.define do
  factory :term do
    glossary
    source_term { 'test' }
    target_term { 'test' }
  end
end
