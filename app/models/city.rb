class City < ApplicationRecord
	mount_uploader :front_image, LogoUploader
	mount_uploader :back_image, LogoUploader
end
