FactoryBot.define do
  factory :shop do
  	# id Faker::Number.number(10)
    title "#{Faker::Company.name} #{Faker::Company.suffix}"
    description Faker::Lorem.paragraph(10)
    url Faker::Internet.url
    phones { Array.new(6) { FactoryBot.build(:phone) } }
    opening_hours { Array.new(4) { FactoryBot.build(:opening_hour) } }
    city {FactoryBot.build(:city)}
  end
end
