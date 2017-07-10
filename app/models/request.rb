class Request < ApplicationRecord


  self.inheritance_column = :type

  def self.types
      %w(ContactRequest CallMeBackRequest)
  end

  scope :contacts, -> { where(type: 'ContactRequest') } 
  scope :callmebacks, -> { where(type: 'CallMeBackRequest') } 

  private

  def contact_request?
    self.type == 'ContactRequest'
  end
end
