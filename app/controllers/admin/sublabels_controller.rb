class Admin::SublabelsController < AdminController
include CrudConcern

  before_action :find_sublabel, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    @sublabels = Sublabel.all
  end

  def new
    @sublabel = Sublabel.new
  end

  def create
    @sublabel = Sublabel.new(sublabel_params)
    create_helper(@sublabel, "edit_admin_sublabel_path")
  end

  def update
    update_helper(@sublabel, "edit_admin_sublabel_path", sublabel_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@sublabel, "admin_sublabels_path")
  end

  private

  def find_sublabel
    @sublabel = Sublabel.find(params[:id])
  end

  def sublabel_params
    params.require(:sublabel).permit(Sublabel.attribute_names.map(&:to_sym))
  end

end

