class Admin::ManufacturersController < AdminController
include CrudConcern

  before_action :find_manufacturer, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    if params[:sublevel]
      # Это эквивалентно с
      # @manufacturers = Manufacturer.subs
      @manufacturers = index_helper('Manufacturer', scope: 'subs')
    else
      @manufacturers = index_helper('Manufacturer', scope: 'top_level')
    end
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    create_helper(@manufacturer, "edit_admin_manufacturer_path")
  end

  def update
    update_helper(@manufacturer, "edit_admin_manufacturer_path", manufacturer_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@manufacturer, "admin_manufacturers_path")
  end

  private

  def find_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end

  def manufacturer_params
    params.require(:manufacturer).permit(Manufacturer.attribute_names.map(&:to_sym))
  end

end


