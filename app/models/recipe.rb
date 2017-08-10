class Recipe < ApplicationRecord
  mount_uploader :logo, LogoUploader
  belongs_to :recipe_category

  validates :recipe_category, :title, presence: true

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
end
