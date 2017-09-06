class RecipeCategory < ApplicationRecord
  has_many :recipes

  extend FriendlyId
  friendly_id :title, use: [:finders, :slugged]

  mount_uploader :logo, LogoUploader
end
