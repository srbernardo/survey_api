FactoryBot.define do
  factory :survey do
    user
    title { Faker::Book.title }
    open { true }
  end
end
