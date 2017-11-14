FactoryBot.define do
  factory :manufacturer do
    sequence(:title) {|n| Faker::Company.name + Faker::Company.suffix + " (#{n})"}
    # title { "#{Faker::Company.name} #{Faker::Company.suffix}" }
    description { Faker::Lorem.paragraph(10) }
    # logo "MyString"
    # parent_id 1
    active { true }
  end
end
