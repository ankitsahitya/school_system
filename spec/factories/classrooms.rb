FactoryGirl.define do
  factory :classroom do
    school_id { FactoryGirl.create(:school).id }
    room_no Faker::Number.number(2)
    class_no Faker::Number.between(1,12)
  end
end
