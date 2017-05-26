class RecipeCategory < ApplicationRecord
  has_many :recipes

  mount_uploader :logo, LogoUploader
end
