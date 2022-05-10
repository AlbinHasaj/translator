FactoryBot.define do
  factory :translation do
    glossary
    source_language_code { 'aa' }
    target_language_code { 'aa' }
    source_text { 'test test test not' }
  end
end
