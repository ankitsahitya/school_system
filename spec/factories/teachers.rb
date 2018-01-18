FactoryGirl.define do
  factory :teacher do
    school_id { FactoryGirl.create(:school).id }
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no Faker::Number.number(10)
    gender %w[male female].sample
  end
end
