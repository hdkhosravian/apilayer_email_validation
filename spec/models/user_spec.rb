require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    subject(:user) { create(:user) }

    it { expect(user).to validate_presence_of(:first_name) }
    it { expect(user).to validate_presence_of(:last_name) }
    it { expect(user).to validate_presence_of(:url) }
  end
end
