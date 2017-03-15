class GeneralSetting < ApplicationRecord
	mount_uploader :logo, LogoUploader
	
	store_accessor :language, :en
	store_accessor :language, :ru

	has_many :phones, dependent: :destroy

	accepts_nested_attributes_for :phones, :allow_destroy => true
end
