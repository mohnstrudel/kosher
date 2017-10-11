class Seo < ApplicationRecord
  belongs_to :posts

  mount_uploader :image, LogoUploader
end
