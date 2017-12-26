class Admin::Settings::CitiesController < AdminController
  include CrudConcern

  before_action :find_city, only: [:edit, :destroy, :update]

  def index
    @cities = index_helper("City")
  end

  def new
    @city = City.new
    @city.build_seo
  end

  def edit
    if @city.seo.blank?
      @city.build_seo
    end
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
    @city = City.friendly.find(params[:id])
  end

  def city_params
    params.require(:city).permit(:front_image, :sortable, :back_image, :name, seo_attributes: [:id, :title, :description, :image, keywords: [] ])
  end

end
