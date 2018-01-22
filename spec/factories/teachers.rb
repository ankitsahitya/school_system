FactoryGirl.define do
  factory :teacher do
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no Faker::Number.number(10)
    gender %w[male female].sample
  end
end
