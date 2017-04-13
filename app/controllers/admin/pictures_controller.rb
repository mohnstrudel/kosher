class Admin::PicturesController < AdminController
  include CrudConcern

  before_action :find_picture, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    @pictures = index_helper("Picture")
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    create_helper(@picture, "edit_admin_picture_path")
  end

  def update
    update_helper(@picture, "edit_admin_picture_path", picture_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@picture, "admin_pictures_path")
  end

  private

  def find_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(Picture.attribute_names.map(&:to_sym))
  end

end

