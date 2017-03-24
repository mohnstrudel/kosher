class Label < ApplicationRecord
	mount_uploader :logo, LogoUploader

  has_many :products
end
