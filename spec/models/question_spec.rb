require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:survey) { create(:survey) }

  describe '#limit_radio_button_questions' do
    context 'when question is radio_button' do
      it 'does not allow more than 10 questions' do
        create_list(:question, 10, survey:, option: 'radio_button')

        question = build(:question, survey:, option: 'radio_button')

        expect(question).not_to be_valid
        expect(question.errors[:base]).to include('You cannot add more than 10 "radio button" questions to this survey.')
      end
    end

    context 'when question is not radio_button' do
      it 'allows more than 5 choices' do
        create_list(:question, 11, option: 'checkboxe')

        question = build(:question, survey:, option: 'checkboxe')

        expect(question).to be_valid
      end
    end
  end

  describe '#swap_order' do
    it 'swaps the order with another question' do
      question1 = create(:question, survey:, order: 1)
      question2 = create(:question, survey:, order: 2)

      question1.update(order: 2)

      expect(question2.reload.order).to eq(1)
      expect(question1.reload.order).to eq(2)
    end
  end

  describe '#ensure_unique_order' do
    it 'does not allow duplicate orders within the same survey' do
      create(:question, survey: survey, order: 1)

      question = build(:question, survey:, order: 1)

      expect(question).not_to be_valid
      expect(question.errors[:order]).to include("There is already a question with this order in this survey.")
    end

    it 'allows the same order in different surveys' do
      survey1 = create(:survey)
      survey2 = create(:survey)

      create(:question, survey: survey1, order: 1)

      question = build(:question, survey: survey2, order: 1)

      expect(question).to be_valid
    end
  end

  describe '#completed?' do
    let(:survey) { create(:survey) }
    let(:user) { create(:user) }

    context 'when option is radio_button' do
      let(:question) { create(:question, option: "radio_button", survey:) }
      let!(:choice) { create(:choice, question:) }

      it 'returns true if the user has answered' do
        create(:choice_answer, choice:, user:)

        expect(question.completed?(user.id)).to be(true)
      end

      it 'returns false if the user has not answered' do
        expect(question.completed?(user.id)).to be(false)
      end
    end

    context 'when option is checkboxe' do
      let(:question) { create(:question, option: "checkboxe", survey:) }
      let!(:choice) { create(:choice, question:) }

      it 'returns true if the user has answered' do
        create(:choice_answer, choice:, user:)

        expect(question.completed?(user.id)).to be(true)
      end

      it 'returns false if the user has not answered' do
        expect(question.completed?(user.id)).to be(false)
      end
    end

    context 'when option is single_line_answer' do
      let(:question) { create(:question, option: "single_line_answer", survey:) }

      it 'returns true if the user has answered' do
        create(:single_line_answer, question:, user:)
        expect(question.completed?(user.id)).to be(true)
      end

      it 'returns false if the user has not answered' do
        expect(question.completed?(user.id)).to be(false)
      end
    end

    context 'when option is multi_line_answer' do
      let(:question) { create(:question, option: "multi_line_answer", survey:) }

      it 'returns true if the user has answered' do
        create(:multi_line_answer, question:, user:)

        expect(question.completed?(user.id)).to be(true)
      end

      it 'returns false if the user has not answered' do
        expect(question.completed?(user.id)).to be(false)
      end
    end
  end
end
