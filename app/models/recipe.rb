class Recipe < ApplicationRecord
  mount_uploader :logo, LogoUploader
  belongs_to :recipe_category

  validates :recipe_category, :title, presence: true
end
