FactoryGirl.define do
  factory :post_category do
    title { Faker::Lorem.sentence }
  end
end
