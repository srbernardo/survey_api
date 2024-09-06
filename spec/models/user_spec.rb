require 'rails_helper'

RSpec.describe User, type: :model do
   describe '#coordinator?' do
    context 'when the user is a coordinator' do
      let(:coordinator) { create(:user, role: :coordinator) }

      it 'returns true' do
        expect(coordinator.coordinator?).to be true
      end
    end

    context 'when the user is a respondent' do
      let(:respondent) { create(:user, role: :respondent) }

      it 'returns false' do
        expect(respondent.coordinator?).to be false
      end
    end
  end
end
