class Question < ApplicationRecord
  belongs_to :survey

  has_one :multi_line_answer, dependent: :destroy
  has_one :single_line_answer, dependent: :destroy
  has_many :choices, dependent: :destroy

  enum option: { checkboxe: 0, radio_button: 1, single_line_answer: 2, multi_line_answer: 3 }

  validate :limit_radio_button_questions, on: :create

  def completed?
    case option
    when "checkboxe", "radio_button"
      choices.any?(&:marked)
    when "single_line_answer"
      single_line_answer&.value.present?
    else
      multi_line_answer&.value.present?
    end
  end

  private

  def limit_radio_button_questions
    if survey.questions.where(option: 'radio_button').count >= 10 && option == 'radio_button'
      errors.add(:base, 'You cannot add more than 10 "radio button" questions to this survey.')
    end
  end
end
