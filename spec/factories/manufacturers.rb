FactoryGirl.define do
  factory :manufacturer do
    title { "#{Faker::Company.name} #{Faker::Company.suffix}" }
    description { Faker::Lorem.paragraph(10) }
    # logo "MyString"
    # parent_id 1
  end
end
