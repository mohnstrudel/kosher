class Product < ApplicationRecord
  belongs_to :category
  belongs_to :label
  belongs_to :manufacturer

  mount_uploader :logo, LogoUploader

  validates :title, :manufacturer, :label, :category, presence: true
  # Можно заменить на validates :title, :manufacturer_id, :label_id, :category_id

  before_save :default_label

  after_save :set_slug

  has_many :product_barcodes, dependent: :destroy
  has_many :barcodes, through: :product_barcodes

  accepts_nested_attributes_for :barcodes, allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: [:finders, :slugged]

  # scope :filtered_by_category, -> (id) { where(category_id: id) }

  # scope :incomplete, -> { where(manufacturer: nil).or(where(label: nil)).or(where(category: nil)).or(where(title: nil)) }
  
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
    if self.slug.blank?
      begin
        slugged = Translit.convert(self.title, :english).downcase
        slugged = slugged.split(" ").join("-").delete(".")
        self.slug = slugged
      rescue NoMethodError => e
        self.slug = nil
      end
    end
  end
end
