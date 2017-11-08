class Front::RequestsController < FrontController
  before_action :set_type


  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.js
        
        # @request.send_notifications
        if Rails.env.production?
          RequestMailer.delay(queue: "admin", priority: 20).notify_admin(@request)
        elsif Rails.env.development?
          RequestMailer.notify_admin(@request).deliver_now
        end
      else
        format.js { render partial: 'fail' }
        
      end
    end
  end

  private

  def set_request
    @request = type_class.find(params[:id])
  end

  def set_type
     @type = type
  end

  def type
      Request.types.include?(params[:type]) ? params[:type] : "Request"
  end

  def type_class 
      type.constantize 
  end

  def request_params
    params.require(type.underscore.to_sym).permit(Request.attribute_names.map(&:to_sym))
  end
end
