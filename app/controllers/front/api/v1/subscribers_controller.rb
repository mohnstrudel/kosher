module Front
  module Api::V1
    class SubscribersController < ApiController

      skip_before_action :verify_authenticity_token, if: :json_request?

      include ApiConcern

      # GET /v1/events
      def index
        index_helper('subscribers')
      end

      def show
        show_helper('subscribers')
      end

      def create
        @subscriber = Subscriber.new(subscriber_params)

        respond_to do |format|
          if @subscriber.save
            format.json { render json: @subscriber, status: :created}
          else
            format.json { render json: @subscriber.errors, status: :unprocessable_entity}
          end
        end
      end


      private

      def subscriber_params
        params.require(:subscriber).permit(:email)
      end

      protected

      def json_request?
        request.format.json?
      end
    end
  end
end