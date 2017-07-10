class ContactRequest < Request
  validates :name, :phone, :email, :company_name, presence: true

  def self.sti_name
    "ContactRequest"
  end
end
