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
end
