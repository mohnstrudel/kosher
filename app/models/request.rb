class Request < ApplicationRecord


  self.inheritance_column = :type

  def self.types
      %w(ContactRequest CallMeBackRequest)
  end

  scope :contacts, -> { where(type: 'ContactRequest') } 
  scope :callmebacks, -> { where(type: 'CallMeBackRequest') } 

  def send_notifications
    if Rails.env.production?
      RequestMailer.delay(queue: "admin", priority: 20).notify_admin(self)
    elsif Rails.env.development?
      RequestMailer.notify_admin(self).deliver_now
    end
  end

  private

  def contact_request?
    self.type == 'ContactRequest'
  end
end
