class Admin::LabelsController < AdminController
  
  include CrudConcern

  before_action :find_label, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    if params[:sublevel]
      @labels = index_helper('Label', scope: 'subs')
    else
      # Это эквивалентно с
      # @labels = Label.top_level
      @labels = index_helper('Label', scope: 'top_level')
      
    end
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    create_helper(@label, "edit_admin_label_path")
  end

  def update
    update_helper(@label, "edit_admin_label_path", label_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@label, "admin_labels_path")
  end

  private

  def find_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(Label.attribute_names.map(&:to_sym))
  end

end

