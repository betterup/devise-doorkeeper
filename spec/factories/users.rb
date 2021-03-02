FactoryBot.define do
  sequence(:email) { "jon.doe+#{SecureRandom.hex(10)}@acme.com" }

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
