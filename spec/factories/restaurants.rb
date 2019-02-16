FactoryBot.define do
  factory :restaurant do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(10) }
    url { Faker::Lorem.word }
    logo { Faker::Lorem.word }
    address { Faker::Lorem.word }
  end
end
