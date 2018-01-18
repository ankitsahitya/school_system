FactoryGirl.define do
  factory :school do
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no Faker::Number.number(10)
    code Faker::Number.number(5)
  end
end
