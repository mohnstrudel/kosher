FactoryBot.define do
  factory :recipe_category do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(10) }
    logo { Faker::Lorem.word }
  end
end
