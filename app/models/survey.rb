class Survey < ApplicationRecord
  belongs_to :user

  has_many :questions, dependent: :destroy

  validates :title, presence: true

  def completed?
    questions.all? { |question| question.completed? }
  end

  def can_submit?
    if completed?
      true
    else
      errors.add(:base, "Survey is incomplete. Please complete all questions before submitting.")
      false
    end
  end

  def result
    hash = {}
    survey_questions = questions.where(option: 'radio_button')

    survey_questions.each do |question|
      hash["Question id #{question.id}"] = {}

      question.choices.each do |choice|
        count = choice.choice_answers.count
        hash["Question id #{question.id}"]["Choice id #{choice.id}"] = count
      end
    end

    hash
  end
end
