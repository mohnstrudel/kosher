class Phone < ApplicationRecord
  belongs_to :general_setting, optional: true
  belongs_to :shop, optional: true
end
