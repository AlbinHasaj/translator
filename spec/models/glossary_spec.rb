require 'rails_helper'

RSpec.describe Glossary, type: :model do
  it { is_expected.to validate_inclusion_of(:target_language_code).in_array(Language.all_codes).with_message('Must be a valid language code.') }
  it { is_expected.to validate_inclusion_of(:source_language_code).in_array(Language.all_codes).with_message('Must be a valid language code.') }
  it { is_expected.to validate_uniqueness_of(:source_language_code).scoped_to(:target_language_code).with_message('Glossary already exists.') }
end
