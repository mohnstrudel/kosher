class Front::SubscribersController < FrontController

  def create
    @subscriber = Subscriber.new(subscriber_params)
    respond_to do |format|
      if @subscriber.valid?
        SubscriberMailer.subscriber_confirmation(@subscriber).deliver_now
        format.js
      else
        format.js { render partial: 'fail' }
      end
    end
  end

  def confirm_email
    subscriber = Subscriber.find_or_create_by(confirm_token: params[:id])

    if subscriber
      # Внутри email_activate и происходит сохранение записи
      subscriber.email_activate(params)
      # Передать параметры после подтверждения
      # chimp = Mailchimp.new(subscriber)
      # chimp.delay.subscribe
      redirect_to root_path(email_confirmed: true)
    else
      # render partial: 'subscribers/fail', formats: [:js]
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(Subscriber.attribute_names.map(&:to_sym))
  end
end
