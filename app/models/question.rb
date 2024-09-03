class Question < ApplicationRecord
  belongs_to :survey

  has_one :multi_line_answers, dependent: :destroy
  has_one :single_line_answers, dependent: :destroy
  has_many :choices, dependent: :destroy

  enum option: { checkboxe: 0, radio_Button: 1, single_line_answer: 2, multi_line_answer: 3 }
end
