class Front::GeneralSettingsController < ApplicationController

  def list
    @about = GeneralSetting.first

    respond_to do |format|
      format.html
      format.json { render json: @about, status: 200}
    end
  end
end
