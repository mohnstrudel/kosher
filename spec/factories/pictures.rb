FactoryBot.define do
  factory :picture do
    title { Faker::Lorem.word }
    description { Faker::Lorem.word }
    image { Faker::Lorem.word }
  end
end
