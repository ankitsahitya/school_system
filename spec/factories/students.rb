FactoryGirl.define do
  factory :student do
    classroom = FactoryGirl.create(:classroom)
    school_id classroom.school_id
    classroom_id classroom.id
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no Faker::Number.number(10)
    gender %w[male female].sample
  end
end
