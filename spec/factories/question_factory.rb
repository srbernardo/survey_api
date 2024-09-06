FactoryBot.define do
  factory :question do
    survey
    title { Faker::Book.title }
    option { Question.options.keys.sample }
    sequence(:order) { |n| n }
  end
end
