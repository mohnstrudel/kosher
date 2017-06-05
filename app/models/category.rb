class Category < ApplicationRecord

  has_many :products
  # has_one :label
  # This is called a self referential relation. This is where records in a 
  # table may point to other records in the same table.
  has_many :sub_categories, class_name: "Category", foreign_key: :parent_id

  # This is a scope to load the top level categories and eager-load their 
  # lawyers, subcategories, and the subcategories' lawyers too.
  # scope :top_level, -> { where(parent_id: nil).include :products, sub_categories: :products }
  scope :top_level, -> { where(parent_id: nil) }
  # scope :subs, lambda { where("parent_id NOT NULL").include :products }
  scope :subs, lambda { where("parent_id IS NOT NULL") }

  validates :title, presence: true

  has_many :manufacturers, through: :products

  mount_uploader :logo, LogoUploader

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
    parent = find(id)

    children_ids = parent.sub_categories.map { |item| item.id }

    # На первом месте всегда айди родителя, потом идут айди детей
    # Пример - [1, 4, 7, 10]
    return [parent.id, children_ids].flatten!
  end
end
