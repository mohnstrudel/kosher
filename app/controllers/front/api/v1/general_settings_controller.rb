module Front
  module Api::V1
    class GeneralSettingsController < ApiController
      
      def list
        @status = 200

        begin
          @about = GeneralSetting.first
        rescue => e
          @about = e.message
          @status = 400
        end

        respond_to do |format|
          format.json {
            render json: @about, status: @status
          }
        end
      end

    end
  end
end