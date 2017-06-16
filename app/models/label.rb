class Label < ApplicationRecord
  has_many :products
  # This is called a self referential relation. This is where records in a 
  # table may point to other records in the same table.
  has_many :sub_labels, class_name: "Label", foreign_key: :parent_id, dependent: :destroy
  has_many :categories, through: :products

  # before_destroy :destroy_children, if: :has_children?

  # This is a scope to load the top level categories and eager-load their 
  # lawyers, subcategories, and the subcategories' lawyers too.
  # scope :top_level, -> { where(parent_id: nil).include :products, sub_categories: :products }
  scope :top_level, -> { where(parent_id: nil)}
  # scope :subs, lambda { where("parent_id NOT NULL").include :products }
  scope :subs, lambda { where("parent_id IS NOT NULL") }

  validates :title, presence: true

  mount_uploader :logo, LogoUploader

  def self.has_children?(id)
    if find(id).sub_labels.empty?
      return false
    else
      return true
    end
  end

  def self.return_collection(id)
    # Мы получаем айди родителя
    # возвращаем в массиве айди всех детей
    parent = find(id)

    children_ids = parent.sub_labels.map { |item| item.id }

    # На первом месте всегда айди родителя, потом идут айди детей
    # Пример - [1, 4, 7, 10]
    return [parent.id, children_ids].flatten!
  end

  # def children
  #   self.class.subs.where(parent_id: id)
  # end

  # def destroy_children
  #   children.destroy_all
  # end

  # def has_children?
  #   self.class.exists?(inverse_match_options)
  # end

  # def inverse_match_options
  #   { parent_id: id }
  # end
end
