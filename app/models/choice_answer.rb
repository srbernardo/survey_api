class ChoiceAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :choice

  has_one :question, through: :choice
end
