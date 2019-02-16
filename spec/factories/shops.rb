FactoryBot.define do
  factory :shop do
  	# id Faker::Number.number(10)
    title do
      "#{Faker::Company.name} #{Faker::Company.suffix}"
    end
    description { Faker::Lorem.paragraph(10) }
    url { Faker::Internet.url }
    phones { Array.new(6) { FactoryBot.build(:phone) } }
    opening_hours { Array.new(4) { FactoryBot.build(:opening_hour) } }
    city {FactoryBot.build(:city)}
  end
end
