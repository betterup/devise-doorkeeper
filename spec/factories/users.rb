FactoryBot.define do
  sequence(:email) { "jon.doe+#{SecureRandom.hex(10)}@acme.com" }

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { Time.current }

    trait :when_unconfirmed do
      confirmed_at { nil }
    end
  end
end
