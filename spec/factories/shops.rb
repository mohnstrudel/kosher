FactoryGirl.define do
  factory :shop do
  	id Faker::Number.number(1)
    title "#{Faker::Company.name} #{Faker::Company.suffix}"
    description Faker::Lorem.paragraph(10)
    url Faker::Internet.url
    phones { Array.new(6) { FactoryGirl.build(:phone) } }
    opening_hours { Array.new(4) { FactoryGirl.build(:opening_hour) } }
  end
end
