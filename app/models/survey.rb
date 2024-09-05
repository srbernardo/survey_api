class Survey < ApplicationRecord
  belongs_to :user

  has_many :questions, dependent: :destroy

  validates :title, presence: true

  def completed?
    questions.all? { |question| question.completed? }
  end
end
