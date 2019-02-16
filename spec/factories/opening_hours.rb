FactoryBot.define do
  factory :opening_hour do
    title do
      Faker::Date.between(2.days.ago, Date.today)
    end
    value do
      "#{Faker::Number.number(2)}:#{Faker::Number.number(2)} - #{Faker::Number.number(2)}:#{Faker::Number.number(2)}"
    end
  end
end
