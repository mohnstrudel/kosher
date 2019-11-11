class Seo < ApplicationRecord
  belongs_to :posts
  belongs_to :banquet_halls

  mount_uploader :image, LogoUploader
end
