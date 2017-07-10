class CallMeBackRequest < Request
  validates :name, :phone, presence: true
  # Code here
  def self.sti_name
    "CallMeBackRequest"
  end
end
