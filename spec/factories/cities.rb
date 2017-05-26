require 'faker'

FactoryGirl.define do
  factory :city do |f|
  	# f.id { 1 }
    f.front_image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/files/rails.jpg'))) }
    f.back_image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/files/rails.jpg'))) }
    f.name { Faker::Address.city }
  end
end
