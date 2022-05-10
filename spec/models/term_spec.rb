require 'rails_helper'

RSpec.describe Term, type: :model do
  it { is_expected.to validate_presence_of(:source_term) }
  it { is_expected.to validate_presence_of(:target_term) }
end
