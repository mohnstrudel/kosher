class Manufacturer < ApplicationRecord
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

  validates :title, presence: true

  has_many :categories, through: :products
  has_many :labels, through: :products

  mount_uploader :logo, LogoUploader

  def self.has_children?(id)
    if find(id).trademarks.empty?
      return false
    else
      return true
    end
  end

  def self.by_filter(category = nil, subcategory = nil, manufacturer = nil, sign = nil)

    subcategory = nil if subcategory == 'any'
    category = nil if category == 'any'
    if category && subcategory
      category = subcategory
    elsif !category && subcategory
      category = subcategory
    end

    if !category && !subcategory && !manufacturer && !sign
      return all
    end

    return Manufacturer.find(manufacturer).trademarks if !category && !subcategory && manufacturer && !sign
      

    params = Hash(category: category, manufacturer: manufacturer, label: sign)

    @products = Product.where(nil)
    params.each do |key, value|
      @products = @products.where(key => value) if value.present?
    end
    p "Inspecting products:"
    puts @products.inspect

    p "By category and parent params:"
    p params
    
    return @products.map { |product| product.manufacturer }
  end

  def self.return_collection(id)
    # Мы получаем айди родителя
    # возвращаем в массиве айди всех детей
    parent = find(id)

    children_ids = parent.trademarks.map { |item| item.id }

    # На первом месте всегда айди родителя, потом идут айди детей
    # Пример - [1, 4, 7, 10]
    return [parent.id, children_ids].flatten!
  end

end
