class Admin::PartnersController < AdminController
  include CrudConcern

  before_action :find_partner, only: [:edit, :update, :destroy]

  def index
    # @partners = Partner.all
    @partners = index_helper("Partner")
  end

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.new(partner_params)
    create_helper(@partner, "edit_admin_partner_path")
  end

  def update
    update_helper(@partner, "edit_admin_partner_path", partner_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@partner, "admin_partners_path")
  end

  private

  def find_partner
    @partner = Partner.find(params[:id])
  end

  def partner_params
    params.require(:partner).permit(Partner.attribute_names.map(&:to_sym))
  end

end
