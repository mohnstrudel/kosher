class GeneralSettingSerializer < ActiveModel::Serializer
  attributes :id, :url, :logo, :description, :address, :email, :opening_hours

  has_many :phones
end
