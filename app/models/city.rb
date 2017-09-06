class City < ApplicationRecord
  has_many :shops
  has_many :restaurants

  extend FriendlyId
  friendly_id :name, use: [:finders, :slugged]

	mount_uploader :front_image, LogoUploader
	mount_uploader :back_image, LogoUploader

	validates :front_image, presence: true
	validates :back_image, presence: true
end
