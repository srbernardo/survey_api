FactoryBot.define do
  factory :multi_line_answer do
    question
    user
    value { Faker::Book.title }
  end
end
