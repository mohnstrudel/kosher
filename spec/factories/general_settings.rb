FactoryGirl.define do
  factory :general_setting do
    url Faker::Internet.url
    description Faker::Lorem.paragraph(10)
    # association :phone, factory: :user, strategy: :build
    phones { Array.new(3) { FactoryGirl.build(:phone) } }
    opening_hours { Array.new(5) { FactoryGirl.build(:opening_hour) } }
  end
end
