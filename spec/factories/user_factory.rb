FactoryBot.define do
  sequence :email do |n|
    "user-#{n}@email.com"
  end

  factory :user do
    email
    password { "123456" }
    role { "respondent" }

    trait :coordinator do
      role { "coordinator" }
    end

    trait :respondent do
      role { "respondent" }
    end
  end
end
