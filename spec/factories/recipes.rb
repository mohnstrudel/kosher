FactoryBot.define do
  factory :recipe do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(10) }
    logo { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/files/rails.jpg'))) }
    recipe_category { FactoryBot.create(:recipe_category) }
  end
end
