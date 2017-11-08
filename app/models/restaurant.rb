class Restaurant < ApplicationRecord

  include Utility

  belongs_to :city
  
	mount_uploader :logo, LogoUploader

	has_many :phones, dependent: :destroy
	has_many :opening_hours, dependent: :destroy

	accepts_nested_attributes_for :phones, allow_destroy: true
	accepts_nested_attributes_for :opening_hours, allow_destroy: true

  has_one :seo
  accepts_nested_attributes_for :seo, allow_destroy: true

	validates :title, presence: true

  extend FriendlyId
  friendly_id :slug_candidates, use: [:finders, :slugged]

  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end

  def set_slug
    unless self.nil?
      begin
        slugged = self.title.parameterize
        begin 
          Restaurant.friendly.find(slugged)
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