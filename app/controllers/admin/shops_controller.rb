class Admin::ShopsController < AdminController
  include CrudConcern

  before_action :find_shop, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    create_helper(@shop, "edit_admin_shop_path")
  end

  def update
    update_helper(@shop, "edit_admin_shop_path", shop_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@shop, "admin_shops_path")
  end

  private

  def find_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(Shop.attribute_names.map(&:to_sym).push(
      phones_attributes: [:id, :value, :_destroy, :shop_id ]).push(
      opening_hours_attributes: [:id, :title, :value, :_destroy, :shop_id]) )
  end

end
