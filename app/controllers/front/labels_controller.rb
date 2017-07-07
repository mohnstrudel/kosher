class Front::LabelsController < FrontController

  def index
    @labels = Label.subs
  end
end
