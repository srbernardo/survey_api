class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :surveys, dependent: :destroy
  has_many :choice_answers, dependent: :destroy

  enum role: { respondent: 0, coordinator: 1 }

  def coordinator?
    role == "coordinator"
  end
end
