FactoryBot.define do
  factory :product do
    category { FactoryBot.create(:category, parent_id: (FactoryBot.create(:category)).id) }
    label { FactoryBot.create(:label, parent_id: (FactoryBot.create(:label)).id) }
    manufacturer { FactoryBot.create(:manufacturer, parent_id: (FactoryBot.create(:manufacturer)).id) }
    sequence(:title) {|n| Faker::Name::first_name + " (#{n})"}
    # title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(10) }
    logo { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/files/rails.jpg'))) }
    barcode { Faker::Number.number(6) }
    active { true }
  end
end
