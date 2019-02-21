FactoryBot.define do
  factory :partner do
    title { Faker::Lorem.word }
    logo { Faker::Lorem.word }
    logo_grey { Faker::Lorem.word }
  end
end
