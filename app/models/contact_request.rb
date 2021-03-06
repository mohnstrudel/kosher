class ContactRequest < Request
  validates :name, :phone, :company_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, 
                format: { with: VALID_EMAIL_REGEX }

  def self.sti_name
    "ContactRequest"
  end
end
