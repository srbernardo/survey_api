FactoryBot.define do
  factory :choice do
    question
    value { Faker::Book.title }
  end
end
