class Choice < ApplicationRecord
  belongs_to :question

  has_many :choice_answers, dependent: :destroy

  validate :limit_choices_for_radio_button_questions, on: :create
  validates :value, presence: true

  private

  def limit_choices_for_radio_button_questions
    if question.option == 'radio_button' && question.choices.count >= 5
      errors.add(:base, 'You cannot add more than 5 "choices" for this question.')
    end
  end
end
