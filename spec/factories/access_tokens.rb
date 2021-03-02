FactoryBot.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    resource_owner_id { association(:user).id }
    application_id { association(:application).id }
  end
end
