require 'rails_helper'

RSpec.describe Choice, type: :model do
  let(:question) { create(:question, option: 'radio_button') }

  describe '#limit_choices_for_radio_button_questions' do
    context 'when question is radio_button' do
      it 'does not allow more than 5 choices' do
        create_list(:choice, 5, question: question)

        choice = build(:choice, question: question)

        expect(choice).not_to be_valid
        expect(choice.errors[:base]).to include('You cannot add more than 5 "choices" for this question.')
      end
    end

    context 'when question is not radio_button' do
      let(:question) { create(:question, option: 'checkboxe') }

      it 'allows more than 5 choices' do
        create_list(:choice, 6, question: question)

        choice = build(:choice, question: question)

        expect(choice).to be_valid
      end
    end
  end
end
