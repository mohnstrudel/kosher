class Admin::RestaurantsController < AdminController
  include CrudConcern

  before_action :find_restaurant, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    create_helper(@restaurant, "edit_admin_restaurant_path")
  end

  def update
    update_helper(@restaurant, "edit_admin_restaurant_path", restaurant_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@restaurant, "admin_restaurants_path")
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(Restaurant.attribute_names.map(&:to_sym).push(
      phones_attributes: [:id, :value, :_destroy, :restaurant_id ]).push(
      opening_hours_attributes: [:id, :title, :value, :_destroy, :restaurant_id]) )
  end

end
