class Post < ApplicationRecord
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
    if self.slug.blank?
      # set slug
      self.slug = Translit.convert(self.title)
    end
  end
end
