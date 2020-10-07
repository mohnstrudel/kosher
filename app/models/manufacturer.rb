class Manufacturer < ApplicationRecord

  include Utility
  
  has_many :products
  # This is called a self referential relation. This is where records in a 
  # table may point to other records in the same table.
  has_many :trademarks, class_name: "Manufacturer", foreign_key: :parent_id, dependent: :destroy

  # This is a scope to load the top level categories and eager-load their 
  # lawyers, subcategories, and the subcategories' lawyers too.
  # scope :top_level, -> { where(parent_id: nil).include :products, sub_categories: :products }
  scope :top_level, -> { where(parent_id: nil) }
  # scope :subs, lambda { where("parent_id NOT NULL").include :products }
  scope :subs, lambda { where("parent_id IS NOT NULL") }
  scope :active, -> { where(active: true) }



  validates :title, presence: true

  has_many :categories, through: :products
  has_many :labels, through: :products

  has_one :seo, dependent: :destroy
  accepts_nested_attributes_for :seo, allow_destroy: true

  mount_uploader :logo, LogoUploader

  before_save :set_slug

  extend FriendlyId
  friendly_id :slug_candidates, use: [:finders, :slugged]

  include PgSearch
  multisearchable :against => [:title, :description]

  def slug_candidates
    [
      :name,
      [:name, :id]
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

  def parent_categories
    return nil if self.parent_id != nil
    categories = Array.new
    Manufacturer.find(self.id).trademarks.includes(:categories).map {|trademark| categories << trademark.categories.to_a }

    return categories.flatten.uniq
  end

  def parent_labels
    return nil if self.parent_id != nil
    labels = Array.new
    Manufacturer.find(self.id).trademarks.includes(:labels).map {|trademark| labels << trademark.labels.to_a }

    return labels.flatten.uniq
  end

  def find_children
    self.trademarks.present?
  end

  def self.has_children?(id)
    if find(id).trademarks.empty?
      return false
    else
      return true
    end
  end

  def parent
    if self.parent_id
      Manufacturer.find(self.parent_id)
    end
  end

  def self.by_filter(category = nil, subcategory = nil, manufacturer = nil, sign = nil)

    subcategory = nil if subcategory == 'any'
    category = nil if category == 'any'
    manufacturer = nil if manufacturer == 'any'
    if category && subcategory
      category = subcategory
    elsif !category && subcategory
      category = subcategory
    end

    if !category && !subcategory && !manufacturer && !sign
      return all
    end

    return Manufacturer.find(manufacturer).trademarks if !category && !subcategory && !manufacturer && !sign
    
    if category.present?
      category = Category.return_collection(category)
    end

    if manufacturer.present?
      manufacturer = Manufacturer.return_collection(manufacturer)
    end

    params = Hash(category: category, manufacturer: manufacturer, label: sign)

    @products = Product.where(nil)
    params.each do |key, value|
      @products = @products.where(key => value) if value.present?
    end
    
    return @products.map { |product| product.manufacturer }
  end

  def self.return_collection(id)
    # Мы получаем айди родителя
    # возвращаем в массиве айди всех детей
    return all if id == 'any'

    parent = find(id)

    children_ids = parent.trademarks.map { |item| item.id }

    # На первом месте всегда айди родителя, потом идут айди детей
    # Пример - [1, 4, 7, 10]
    return [parent.id, children_ids].flatten!
  end

  def set_slug
    unless self.nil?
      slugged = self.title.parameterize
      begin
        Manufacturer.friendly.find(slugged)
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
