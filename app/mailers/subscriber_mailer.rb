class SubscriberMailer < ApplicationMailer
  # default from: 'Оповещения kosher.ru <form@kosher.ru>'
  default from: 'Оповещения kosher.ru <mohnstrudel@yandex.ru>'

  layout 'mailer'

  def subscriber_confirmation(subscriber)
    @subscriber = subscriber

    mail to: subscriber.email, subject: "Подтверждение электронной почты для рассылки"
  end
end

