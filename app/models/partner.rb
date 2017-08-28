class Partner < ApplicationRecord

 mount_uploader :logo, LogoUploader
 mount_uploader :logo_grey, LogoUploader

 validates :logo, :logo_grey, presence: true

end
