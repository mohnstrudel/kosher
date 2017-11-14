class Recipe < ApplicationRecord
  mount_uploader :logo, LogoUploader
  belongs_to :recipe_category

  validates :recipe_category, :title, presence: true

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true

  has_one :seo, dependent: :destroy
  accepts_nested_attributes_for :seo

  extend FriendlyId
  friendly_id :slug_candidates, use: [:finders, :slugged]

  after_save :set_slug

  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end

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

  def set_slug
    unless self.title.nil?
      begin
        slugged = self.title.parameterize
        begin 
          Recipe.friendly.find(slugged)
          hash = Rails.application.config.hashids.encode(self.id)
          slugged = "#{slugged}-#{hash}"
          self.slug = slugged
        rescue ActiveRecord::RecordNotFound
          self.slug = slugged  
        end
        
      rescue => e
        logger.debug "Error while saving slug for #{self.inspect}. Error message: #{e.message}"
        self.slug = nil
      end
    end
  end
end
