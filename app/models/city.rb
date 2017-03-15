class City < ApplicationRecord
	mount_uploader :front_image, LogoUploader
	mount_uploader :back_image, LogoUploader

	validates :front_image, presence: true
	validates :back_image, presence: true
end
