FactoryGirl.define do
  factory :product do
    category { FactoryGirl.create(:category, parent_id: (FactoryGirl.create(:category)).id) }
    label { FactoryGirl.create(:label, parent_id: (FactoryGirl.create(:label)).id) }
    manufacturer { FactoryGirl.create(:manufacturer, parent_id: (FactoryGirl.create(:manufacturer)).id) }
    sequence(:title) {|n| Faker::Name::first_name + " (#{n})"}
    # title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(10) }
    logo { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/files/rails.jpg'))) }
    barcode { Faker::Number.number(6) }
  end
end
