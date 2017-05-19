FactoryGirl.define do
  factory :category do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(10) }
    logo { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/files/rails.jpg'))) }
    # parent_id 1
    id { Faker::Number.unique.number(3) }
  end
end
