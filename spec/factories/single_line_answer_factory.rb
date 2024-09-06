FactoryBot.define do
  factory :single_line_answer do
    question
    user
    value { Faker::Book.title }
  end
end
