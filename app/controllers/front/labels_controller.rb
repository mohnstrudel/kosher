class Front::LabelsController < ApplicationController

  def index
    @labels = Label.top_level

    respond_to do |format|
      format.html
      format.json {
        # render json: @labels, include: { sub_lables: [:id,  items: [:name]] }, status: 200
        render json: @labels, include: { sub_lables: [:id,  :title, :description]}, status: 200
      }
    end
  end
end
