require 'rails_helper'

RSpec.describe Survey, type: :model do
  let(:user) { create(:user) }
  let(:survey) { create(:survey, user:) }

  describe '#completed?' do
    it 'returns true if all questions are completed by the user' do
      questions = create_list(:question, 3, survey:)

      questions.each do |question|
        allow_any_instance_of(Question).to receive(:completed?).with(user.id).and_return(true)
      end

      expect(survey.completed?(user.id)).to be(true)
    end

    it 'returns false if any question is not completed by the user' do
      questions = create_list(:question, 3, survey:)

      allow(questions[0]).to receive(:completed?).with(user.id).and_return(true)
      allow(questions[1]).to receive(:completed?).with(user.id).and_return(false)
      allow(questions[2]).to receive(:completed?).with(user.id).and_return(true)

      expect(survey.completed?(user.id)).to be(false)
    end
  end

  describe '#can_submit?' do
    it 'returns true if survey is completed' do
      allow(survey).to receive(:completed?).and_return(true)
      expect(survey.can_submit?).to be(true)
    end

    it 'returns false if survey is not completed and adds error message' do
      allow(survey).to receive(:completed?).and_return(false)
      expect(survey.can_submit?).to be(false)
      expect(survey.errors[:base]).to include('Survey is incomplete. Please complete all questions before submitting.')
    end
  end

  describe '#result' do
    it 'returns a hash with question ids and choice counts' do
      question = create(:question, option: 'radio_button', survey: survey)
      choice1 = create(:choice, question:)
      choice2 = create(:choice, question:)
      create(:choice_answer, choice: choice1)
      create(:choice_answer, choice: choice2)

      result = survey.result

      expect(result).to eq({
        "Question id #{question.id}" => {
          "Choice id #{choice1.id}" => 1,
          "Choice id #{choice2.id}" => 1
        }
      })
    end

    it 'returns empty hash when there are no radio_button questions' do
      question = create(:question, option: 'checkboxe', survey: survey)
      choice1 = create(:choice, question:)
      choice2 = create(:choice, question:)
      create(:choice_answer, choice: choice1)
      create(:choice_answer, choice: choice2)

      expect(survey.result).to eq({})
    end
  end
end
