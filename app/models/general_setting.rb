class GeneralSetting < ApplicationRecord
  mount_uploader :logo, LogoUploader
  
  after_save :set_long_lat

  store_accessor :language, :en
  store_accessor :language, :ru

  has_many :phones, dependent: :destroy
  has_many :opening_hours, dependent: :destroy

  accepts_nested_attributes_for :phones, :allow_destroy => true
  accepts_nested_attributes_for :opening_hours, :allow_destroy => true

  validates :url, presence: true

  private
  
  def set_long_lat
    geocoder = Geocoder.new
    data = geocoder.encode(self.address)
    self.update_column(:long, data[0])
    self.update_column(:lat, data[1])
    # update(long: data[0], lat: data[1])
  end
end
