class City < ApplicationRecord
  has_many :shops
  has_many :restaurants
  has_many :banquet_halls

  has_one :seo, dependent: :destroy
  accepts_nested_attributes_for :seo, allow_destroy: true

  # scope :active_restaurants, lambda { where(self.restaurants.exists?) }

  extend FriendlyId
  friendly_id :name, use: [:finders, :slugged]

	mount_uploader :front_image, LogoUploader
	mount_uploader :back_image, LogoUploader

	validates :front_image, presence: true
	validates :back_image, presence: true


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
