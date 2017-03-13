class Admin::Settings::CitiesController < AdminController
  include CrudConcern

  before_action :find_city, only: [:edit, :destroy, :update]

  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end

  def edit
  end

  def create
    @city = City.new(city_params)
    create_helper(@city, "edit_admin_settings_city_path")
  end

  def destroy
    destroy_helper(@city, "admin_settings_cities_path")
  end

  def update
    # debug
    # @city.update(language: create_hash(params[:city][:language]))
    update_helper(@city, "edit_admin_settings_city_path", city_params)
  end


  private

  def find_city
    @city = City.find(params[:id])
  end

  def city_params
    params.require(:city).permit(:front_image, :back_image, :name)
  end

end
