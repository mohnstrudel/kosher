class Post < ApplicationRecord

  attribute :title
  attribute :body
  
  mount_uploader :logo, LogoUploader

  after_save :set_published_date
  after_save :set_slug

  include Bootsy::Container
  belongs_to :post_category

  validates :title, presence: true

  extend FriendlyId
  friendly_id :title, use: [:finders, :slugged]

  translates :title, :body
  globalize_accessors :locales => [:en, :ru], :attributes => [:title, :body]

  private

  def set_published_date
    if self.published_at.blank?
      self.published_at = self.created_at
      self.save!
    end

  end

  def set_slug
    unless self.nil?
      # if self.slug.blank?
        begin
          slugged = self.title.parameterize
          self.slug = slugged
        rescue => e
          logger.debug "Error while saving slug for #{self.inspect}. Error message: #{e.message}"
          self.slug = nil
        end
      # end
    end
  end
end
