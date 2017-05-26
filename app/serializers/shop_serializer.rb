class ShopSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :url, :logo, :address, :city

  has_many :phones
  has_many :opening_hours
end
