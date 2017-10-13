class Admin::ProductsController < AdminController
  include CrudConcern

  before_action :find_product, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    # @products = Product.all
    @products = index_helper("Product")
  end

  def new
    @product = Product.new
    @product.barcodes.build
    @product.build_seo
  end

  def create
    @product = Product.new(product_params)
    create_helper(@product, "edit_admin_product_path")
  end

  def update
    update_helper(@product, "edit_admin_product_path", product_params)
  end

  def edit
    if @product.barcodes.blank?
      @product.barcodes.build
    end
    if @product.seo.blank?
      @product.build_seo
    end
  end

  def destroy
    destroy_helper(@product, "admin_products_path")
  end

  private

  def find_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(Product.attribute_names.map(&:to_sym).push(barcodes_attributes: [:id, :value, :_destroy, :product_id]).push(seo_attributes: [:id, :title, :description, :image, keywords: []]))
  end

end
