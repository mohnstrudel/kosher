FactoryGirl.define do
  factory :opening_hour do
    title Faker::Date.between(2.days.ago, Date.today)
    value "#{Faker::Number.number(2)}:#{Faker::Number.number(2)} - #{Faker::Number.number(2)}:#{Faker::Number.number(2)}"
  end
end
