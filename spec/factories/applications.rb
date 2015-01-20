FactoryGirl.define do
  factory :application, class: Doorkeeper::Application do
    name 'sample app'
    # uid { SecureRandom.hex(20) }
    # secret { SecureRandom.hex(20) }
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
  end
end
