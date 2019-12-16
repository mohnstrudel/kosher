class Product < ApplicationRecord
  require "ffi-icu"

  belongs_to :category
  belongs_to :label
  belongs_to :manufacturer

  mount_uploader :logo, LogoUploader

  validates :title, :manufacturer, :label, :category, presence: true
  # Можно заменить на validates :title, :manufacturer_id, :label_id, :category_id

  before_save :default_label

  before_save :set_slug

  has_many :product_barcodes, dependent: :destroy
  has_many :barcodes, through: :product_barcodes

  accepts_nested_attributes_for :barcodes, allow_destroy: true

  has_one :seo, dependent: :destroy
  accepts_nested_attributes_for :seo, allow_destroy: true

  extend FriendlyId
  friendly_id :slug_candidates, use: [:finders, :slugged]

  include PgSearch
  multisearchable :against => [:title, :description]

  scope :active, -> { where(active: true) }

  
  def self.filtered_by_category(session_category)
    category = session_category
    query = where(category_id: category)
    if query.any?
      return query
    else
      return all
    end
  end

  def self.sort_by_alphabet(array)
    collator = ICU::Collation::Collator.new("ru")
    # ary = array.pluck(i:title)
    array.sort { |a, b| collator.compare(a.title, b.title) }
  end


  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end

  # scope :filtered_by_category, -> (id) { where(category_id: id) }

  # scope :incomplete, -> { where(manufacturer: nil).or(where(label: nil)).or(where(category: nil)).or(where(title: nil)) }
  
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

  def self.incomplete(show)
    if show
      
      where(manufacturer: nil).or(where(label: nil)).or(where(category: nil)).or(where(title: nil))
      
      # where("product.manufacturer = ? OR product.label = ? OR product.category = ? OR product.title = ?", nil, nil, nil, nil)
    else
      all
    end
  end

  def self.without_barcode(show)
    if show
      left_joins(:barcodes).where(barcodes: {id: nil})
    else
      all
    end
  end

  def self.category_scope(id)
    if (id.nil? || id.empty?)
      all
    elsif Category.has_children?(id)
      collection_ids = Category.return_collection(id)
      where(category_id: collection_ids)
    else
      where(category_id: id)
    end
  end

  def self.label_scope(label_id)
    if (label_id.nil? || label_id.empty?)
      all
    elsif Label.has_children?(label_id)
      collection_ids = Label.return_collection(label_id)
      where(label_id: collection_ids)
    else
      where(label_id: label_id)
    end
  end

  def self.manufacturer_scope(id)
    if (id.nil? || id.empty?)
      all
    elsif Manufacturer.has_children?(id)
      # Get all ids - the manufacturer's and trademarks'
      collection_ids = Manufacturer.return_collection(id)
      where(manufacturer_id: collection_ids)
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

  def set_slug
    unless self.nil?
      slugged = self.title.parameterize
      begin
        Product.friendly.find(slugged)
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
