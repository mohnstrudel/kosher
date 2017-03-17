class Sublabel < ApplicationRecord
  belongs_to :label
  mount_uploader :logo, LogoUploader
end
