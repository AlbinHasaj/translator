require 'csv'

class Language
  def self.all_codes
    Rails.cache.fetch('language_codes') do
      load_languages.pluck(:code)
    end
  end

  def self.load_languages
    CSV.read('language-codes.csv')[1..].map do |language|
      {
        code: language.first,
        country: language.last
      }
    end
  end
end
