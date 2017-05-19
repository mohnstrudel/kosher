class Recipe < ApplicationRecord
  belongs_to :recipe_category

  validates :recipe_category, :title, presence: true
end
