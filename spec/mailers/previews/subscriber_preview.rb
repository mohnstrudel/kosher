# Preview all emails at http://localhost:3000/rails/mailers/subscriber
class SubscriberMailerPreview < ActionMailer::Preview

  def subscriber_confirmation
    SubscriberMailer.with(subscriber: Subscriber.new).subscriber_confirmation(Subscriber.find_or_create_by(email: "test@subscriber.com")) do |s|
      s.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
