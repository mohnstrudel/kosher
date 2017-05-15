class CitySerializer < ActiveModel::Serializer
  attributes :id, :front_image, :back_image, :name, :created_at, :updated_at
  has_many :shops
  has_many :restaurants
end
