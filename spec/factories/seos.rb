FactoryBot.define do
  factory :seo do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(10) }
    image { Faker::Lorem.word }
    keywords { Faker::Lorem.word }
  end
end
