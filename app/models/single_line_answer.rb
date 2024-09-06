class SingleLineAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :value, presence: true
end
