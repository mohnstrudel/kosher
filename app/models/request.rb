class Request < ApplicationRecord

  validates :name, :phone, :email, presence: true
end
