class RequestMailer < ApplicationMailer
  default from: 'Оповещения kosher.ru <form@kosher.ru>'

  layout 'mailer'

  def notify_admin(request)
    @request = request
    if @request.type == 'CallMeBackRequest'
      @subject = 'Пользователь просит перезвонить.'
    elsif @request.type == 'ContactRequest'
      @subject = 'Заполнена форма обратной связи.'
    end

    mail to: GeneralSetting.first.email, subject: @subject
  end
end
