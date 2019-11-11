class Phone < ApplicationRecord
  belongs_to :general_setting, optional: true
  belongs_to :shop, optional: true
  belongs_to :banquet_hall, optional: true
end
