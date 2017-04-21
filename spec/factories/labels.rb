FactoryGirl.define do
  factory :label do
    logo { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/files/rails.jpg'))) }
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(10) }
  end
end
