class Question < ApplicationRecord
  before_update :swap_order

  belongs_to :survey

  has_many :multi_line_answers, dependent: :destroy
  has_many :single_line_answers, dependent: :destroy
  has_many :choices, dependent: :destroy
  has_many :choice_answers, through: :choices

  enum option: { checkboxe: 0, radio_button: 1, single_line_answer: 2, multi_line_answer: 3 }

  validate :limit_radio_button_questions, on: :create
  validate :ensure_unique_order, on: :create
  validates :title, presence: true
  validates :option, presence: true

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

  def swap_order
    return unless order_changed?

    old_order = order_was
    new_order = order

    question_to_swap = survey.questions.find_by(order: new_order)

    if question_to_swap
      question_to_swap.update_column(:order, old_order)
    end
  end

  def ensure_unique_order
    if survey.questions.exists?(order: order)
      errors.add(:order, "There is already a question with this order in this survey.")
    end
  end
end
