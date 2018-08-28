class CallMeBackRequest < Request
  validates :name, :phone, :company_name, :message, presence: true
  # Code here
  def self.sti_name
    "CallMeBackRequest"
  end
end
