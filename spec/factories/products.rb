FactoryGirl.define do
  factory :product do
    category nil
    label nil
    manufacturer nil
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(10) }
    logo { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/files/rails.jpg'))) }
    barcode { Faker::Number.number(6) }
  end
end
