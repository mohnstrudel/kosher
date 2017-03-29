class Picture < ApplicationRecord

  mount_uploader :image, GalleryUploader
end
