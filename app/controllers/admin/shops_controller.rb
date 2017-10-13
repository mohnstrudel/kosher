class Admin::ShopsController < AdminController
  include CrudConcern

  before_action :find_shop, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    # @shops = Shop.all
    @shops = index_helper("Shop")
  end

  def new
    @shop = Shop.new
    if @shop.seo.blank?
      @shop.build_seo
    end
    get_tags
  end

  def create
    @shop = Shop.new(shop_params)
    get_tags
    create_helper(@shop, "edit_admin_shop_path")
  end

  def update
    update_helper(@shop, "edit_admin_shop_path", shop_params)
  end

  def edit
    if @shop.seo.blank?
      @shop.build_seo
    end
    get_tags
  end

  def destroy
    destroy_helper(@shop, "admin_shops_path")
  end

  private

  def get_tags
    @tags = @shop.seo.keywords || ""
  end

  def find_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(Shop.attribute_names.map(&:to_sym).push(
      phones_attributes: [:id, :value, :_destroy, :shop_id ]).push(
      opening_hours_attributes: [:id, :title, :value, :_destroy, :shop_id]).push(
      seo_attributes: [:id, :title, :description, :image, keywords: []]) )
  end

end
