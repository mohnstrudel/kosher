class SubscriberMailer < ApplicationMailer
  default from: 'Оповещения kosher.ru <form@kosher.ru>'

  layout 'mailer'

  def subscriber_confirmation(subscriber)
    @subscriber = subscriber

    mail to: subscriber.email, subject: "Подтверждение электронной почты для рассылки"
  end
end

