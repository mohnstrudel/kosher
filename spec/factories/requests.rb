FactoryBot.define do
  factory :request do
    name { Faker::Lorem.word }
    company_name { Faker::Lorem.word }
    email { Faker::Lorem.word }
    phone { Faker::Lorem.word }
    message { Faker::Lorem.word }
    type { "" }
    subject { Faker::Lorem.word }
  end
end
