class Front::SubscribersController < FrontController
  def create
    @subscriber = Subscriber.new(subscriber_params)
    chimp = Mailchimp.new(subscriber_params)
    respond_to do |format|
      if @subscriber.save
        format.js
        chimp.delay.subscribe
      else
        format.js { render partial: 'fail' }
        
      end
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(Subscriber.attribute_names.map(&:to_sym))
  end
end
