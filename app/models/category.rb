require 'memory_profiler'

class Category < ApplicationRecord

  has_many :products
  # has_one :label
  # This is called a self referential relation. This is where records in a 
  # table may point to other records in the same table.
  has_many :sub_categories, class_name: "Category", foreign_key: :parent_id, dependent: :destroy

  # This is a scope to load the top level categories and eager-load their 
  # lawyers, subcategories, and the subcategories' lawyers too.
  # scope :top_level, -> { where(parent_id: nil).include :products, sub_categories: :products }
  scope :top_level, -> { where(parent_id: nil) }
  # scope :subs, lambda { where("parent_id NOT NULL").include :products }
  scope :subs, lambda { where("parent_id IS NOT NULL") }

  validates :title, presence: true

  has_many :manufacturers, through: :products
  has_many :labels, through: :products

  mount_uploader :logo, LogoUploader

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def parent_manufacturers
    return nil if self.parent_id != nil
    trademarks = Array.new
    manufacturers = Array.new
    
    Category.find(self.id).sub_categories.includes(:manufacturers).map { |subcategory| trademarks << subcategory.manufacturers.to_a  }

    # return manufacturers.flatten.uniq
    # Тут у нас в массиве только торговые марки. Ищем их производителей
    puts "Inspecting trademarks: #{trademarks.inspect}"
    trademarks.flatten.uniq.each do |trademark|
      manufacturers << trademark.parent
    end

    puts "Inspecting manufacturers: #{manufacturers.inspect}"

    return manufacturers.compact.uniq
  end

  def parent_labels
    return nil if self.parent_id != nil
    labels = Array.new

    Category.find(self.id).sub_categories.includes(:labels).map { |subcategory| labels << subcategory.labels }

    return labels.flatten.uniq
  end

  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end

  def find_children
    self.sub_categories.present?
  end

  def self.has_children?(id)
    if find(id).sub_categories.empty?
      return false
    else
      return true
    end
  end

  def self.return_collection(id)
    # Мы получаем айди родителя
    # возвращаем в массиве айди всех детей
    parent = friendly.find(id)

    children_ids = parent.sub_categories.map { |item| item.id }

    # На первом месте всегда айди родителя, потом идут айди детей
    # Пример - [1, 4, 7, 10]
    return [parent.id, children_ids].flatten!
  end
end
