class RecipeCategory < ApplicationRecord
  has_many :recipes
  has_one :seo
  accepts_nested_attributes_for :seo

  extend FriendlyId
  friendly_id :title, use: [:finders, :slugged]

  mount_uploader :logo, LogoUploader

  def seo_title
    self.seo.try(:title)
  end

  def seo_image(request)
    image = seo.try(:image)
    if image
      return "#{request.protocol}#{request.host_with_port}#{image}"
    end
  end

  def seo_description
    self.seo.try(:description)
  end

  def seo_keywords
    keywords = self.seo.try(:keywords)
    if keywords
      keywords.reject(&:empty?).join(",")
    end
  end
end
