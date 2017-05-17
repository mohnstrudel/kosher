class Product < ApplicationRecord
  belongs_to :category
  belongs_to :label
  belongs_to :manufacturer

  mount_uploader :logo, LogoUploader

  validates :title, presence: true

  before_save :default_label

  # scope :filtered_by_category, -> (id) { where(category_id: id) }
  
  def self.category_scope(id)
    if (id.nil? || id.empty?)
      all
    else
      where(category_id: id)
    end
  end

  def self.manufacturer_scope(id)
    if (id.nil? || id.empty?)
      all
    else
      where(manufacturer_id: id)
    end
  end

  def self.search(keywords)
    if (keywords.nil? || keywords.empty?)
      all
    else
      object_search_term = ObjectSearchTerm.new(keywords)
      where(
          object_search_term.where_clause,
          object_search_term.where_args).
        order(object_search_term.order)
    end
  end

  def default_label
    begin
      self.label_id ||= self.category.label_id # note self.status = 'P' if self.status.nil? might be safer (per @frontendbeauty)
    rescue => e
      self.label_id = nil
      logger.debug "Rescued default_label method from product model"
      logger.debug e.message
    end
  end
end
