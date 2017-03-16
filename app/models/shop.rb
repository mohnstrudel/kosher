class Shop < ApplicationRecord

	mount_uploader :logo, LogoUploader

	has_many :phones, dependent: :destroy
	has_many :opening_hours, dependent: :destroy

	accepts_nested_attributes_for :phones, allow_destroy: true
	accepts_nested_attributes_for :opening_hours, allow_destroy: true

	validates :title, presence: true
end
