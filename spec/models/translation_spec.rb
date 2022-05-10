require 'rails_helper'

RSpec.describe Translation, type: :model do
  it { is_expected.to validate_inclusion_of(:target_language_code).in_array(Language.all_codes).with_message('Must be a valid language code.') }
  it { is_expected.to validate_inclusion_of(:source_language_code).in_array(Language.all_codes).with_message('Must be a valid language code.') }
  it { is_expected.to validate_presence_of(:source_text) }
  it { is_expected.to validate_length_of(:source_text).is_at_most(5000) }

  context 'Glossary ID is present' do
    context 'source_language_code and target_language_code are the same in both' do
      it 'Is valid' do
        translation = build(:translation)

        expect(translation).to be_valid
      end
    end

    context 'source_language_code and target_language_code are not the same in both' do
      it 'Is not valid' do
        translation = build(:translation, target_language_code: 'bo')

        expect(translation).to_not be_valid
      end
    end
  end

  describe '#matching_terms' do
    context 'Glossary is not present' do
      it 'Returns an empty array' do
        translation = create(:translation)

        expect(translation.matching_terms).to be_blank
      end
    end

    context 'Glossary is present' do
      it 'Returns an array with matching terms' do
        translation = create(:translation, source_text: 'test not yes')

        create(:term, glossary: translation.glossary, source_term: 'test', target_term: 'test')
        create(:term, glossary: translation.glossary, source_term: 'not', target_term: 'not')

        matching_terms = translation.matching_terms

        expect(matching_terms.first[:glossary_term]).to eq('test')
        expect(matching_terms.first[:highlighted_source_text]).to eq('<HIGHLIGHT>test</HIGHLIGHT> not yes')

        expect(matching_terms.last[:glossary_term]).to eq('not')
        expect(matching_terms.last[:highlighted_source_text]).to eq('test <HIGHLIGHT>not</HIGHLIGHT> yes')
      end
    end
  end
end
