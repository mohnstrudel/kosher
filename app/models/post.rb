class Post < ApplicationRecord

  attribute :title
  attribute :body
  
  mount_uploader :logo, LogoUploader

  after_save :set_published_date
  before_save :set_slug

  has_one :seo, dependent: :destroy
  accepts_nested_attributes_for :seo, allow_destroy: true


  # include Bootsy::Container
  belongs_to :post_category

  validates :title, presence: true

  extend FriendlyId
  friendly_id :title, use: [:finders, :slugged]

  # include PgSearch
  # multisearchable :against => [:title, :body]

  translates :title, :body
  globalize_accessors :locales => [:en, :ru], :attributes => [:title, :body]

  scope :active, -> { where(active: true) }

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

  private

  def set_published_date
    if self.published_at.blank?
      self.published_at = self.created_at
      self.save!
    end

  end

  def set_slug
    unless self.nil?
      slugged = self.title.parameterize
      begin
        Post.friendly.find(slugged)
        hash = Rails.application.config.hashids.encode(rand(99999))
        slugged = "#{slugged}-#{hash}"
        self.slug = slugged
      rescue ActiveRecord::RecordNotFound
        logger.debug "Object is new, setting default slug"
        self.slug = slugged
      rescue => e
        logger.debug "Error while saving slug for #{self.inspect}. Error message: #{e.message}"
        self.slug = nil
      end
    end
  end
end
