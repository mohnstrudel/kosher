FactoryBot.define do
  factory :newsletter do
    title { Faker::Lorem.word }
    body do
      Faker::Lorem.paragraph(10)
    end
    status { Faker::Lorem.word }
  end
end
