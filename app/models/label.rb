class Label < ApplicationRecord
  has_many :products
  # This is called a self referential relation. This is where records in a 
  # table may point to other records in the same table.
  has_many :sub_labels, class_name: "Label", foreign_key: :parent_id, dependent: :destroy

  # before_destroy :destroy_children, if: :has_children?

  # This is a scope to load the top level categories and eager-load their 
  # lawyers, subcategories, and the subcategories' lawyers too.
  # scope :top_level, -> { where(parent_id: nil).include :products, sub_categories: :products }
  scope :top_level, -> { where(parent_id: nil)}
  # scope :subs, lambda { where("parent_id NOT NULL").include :products }
  scope :subs, lambda { where("parent_id IS NOT NULL") }

  validates :title, presence: true

  mount_uploader :logo, LogoUploader

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
