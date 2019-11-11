class Admin::BanquetHallsController < AdminController
  include CrudConcern

  before_action :find_banquet_hall, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    # @banquet_halls = BanquetHall.all
    @banquet_halls = index_helper("BanquetHall")
  end

  def new
    @banquet_hall = BanquetHall.new
    if @banquet_hall.seo.blank?
      @banquet_hall.build_seo
    end
    get_tags
  end

  def create
    @banquet_hall = BanquetHall.new(banquet_hall_params)
    get_tags
    create_helper(@banquet_hall, "edit_admin_banquet_hall_path")
  end

  def update
    update_helper(@banquet_hall, "edit_admin_banquet_hall_path", banquet_hall_params)
  end

  def edit
    if @banquet_hall.seo.blank?
      @banquet_hall.build_seo
    end
    get_tags
  end

  def destroy
    destroy_helper(@banquet_hall, "admin_banquet_halls_path")
  end

  private

  def get_tags
    @tags = @banquet_hall.seo.keywords || ""
  end

  def find_banquet_hall
    @banquet_hall = BanquetHall.find(params[:id])
  end

  def banquet_hall_params
    params.require(:banquet_hall).permit(BanquetHall.attribute_names.map(&:to_sym).push(
      phones_attributes: [:id, :value, :_destroy, :banquet_hall_id ]).push(
      opening_hours_attributes: [:id, :title, :value, :_destroy, :banquet_hall_id]).push(
      seo_attributes: [:id, :title, :description, :image, keywords: [] ]) )
  end

end
