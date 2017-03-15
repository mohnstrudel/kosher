class GeneralSetting < ApplicationRecord
	mount_uploader :logo, LogoUploader
	
	store_accessor :language, :en
	store_accessor :language, :ru

	has_many :phones, dependent: :destroy
	has_many :opening_hours, dependent: :destroy

	accepts_nested_attributes_for :phones, :allow_destroy => true
	accepts_nested_attributes_for :opening_hours, :allow_destroy => true

	validates :url, presence: true
end
