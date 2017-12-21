class Front::LabelsController < FrontController

  def index
    @labels = Label.subs.active
  end
end
