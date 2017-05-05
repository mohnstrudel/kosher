class City < ApplicationRecord
  has_many :shops
  has_many :restaurants
	mount_uploader :front_image, LogoUploader
	mount_uploader :back_image, LogoUploader

	validates :front_image, presence: true
	validates :back_image, presence: true
end
