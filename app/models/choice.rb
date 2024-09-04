class Choice < ApplicationRecord
  belongs_to :question

  validate :limit_choices_for_radio_button_questions, on: :create

  private

  def limit_choices_for_radio_button_questions
    if question.option == 'radio_button' && question.choices.count >= 5
      errors.add(:base, 'You cannot add more than 5 "choices" for this question.')
    end
  end
end
