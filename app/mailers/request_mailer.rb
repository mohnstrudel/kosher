class RequestMailer < ApplicationMailer
  default from: 'Оповещения kosher.ru <info@yadadya.com>'

  layout 'mailer'

  def notify_admin(request)
    @request = request
    if @request.type == 'CallMeBackRequest'
      @subject = 'Пользователь просит перезвонить.'
    elsif @request.type == 'ContactRequest'
      @subject = 'Заполнена форма обратной связи.'
    end

    mail to: "a.kostin.09@gmail.com", subject: @subject
  end
end
