FactoryBot.define do
  factory :subscriber do
    email { Faker::Lorem.word }
  end
end
