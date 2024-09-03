class Question < ApplicationRecord
  belongs_to :survey

  has_one :multi_line_answers, dependent: :destroy
  has_one :single_line_answers, dependent: :destroy
  has_many :choices, dependent: :destroy
end
