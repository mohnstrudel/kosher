class Product < ApplicationRecord
  belongs_to :category
  belongs_to :label
  belongs_to :manufacturer

  mount_uploader :logo, LogoUploader

  validates :title, presence: true

  before_save :default_label
  
  def default_label
    self.label_id ||= self.category.label_id # note self.status = 'P' if self.status.nil? might be safer (per @frontendbeauty)
  end
end
