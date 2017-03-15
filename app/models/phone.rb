class Phone < ApplicationRecord
  belongs_to :general_setting, optional: true
end
