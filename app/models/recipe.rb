class Recipe < ApplicationRecord
  mount_uploader :logo, LogoUploader
  belongs_to :recipe_category

  validates :recipe_category, :title, presence: true

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true

  extend FriendlyId
  friendly_id :slug_candidates, use: [:finders, :slugged]

  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end
end
