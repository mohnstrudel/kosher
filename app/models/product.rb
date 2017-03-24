class Product < ApplicationRecord
  belongs_to :category
  belongs_to :label
  belongs_to :manufacturer

  mount_uploader :logo, LogoUploader

  validates :title, presence: true
end
