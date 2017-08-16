class Admin::NewslettersController < AdminController
  
  include CrudConcern

  before_action :find_newsletter, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]
  before_action :get_templates, only: [:edit, :new]

  def index  
    @newsletters = index_helper("Newsletter")
  end

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    create_helper(@newsletter, "edit_admin_newsletter_path")
    chimp = Mailchimp.new(newsletter_params)
    chimp.delay.deliver_campaign
  end

  def update
    update_helper(@newsletter, "edit_admin_newsletter_path", newsletter_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@newsletter, "admin_newsletters_path")
  end

  private

  def get_templates
    chimp = Mailchimp.new
    @templates = chimp.get_user_templates
  end

  def find_newsletter
    @newsletter = Newsletter.find(params[:id])
  end

  def newsletter_params
    params.require(:newsletter).permit(Newsletter.attribute_names.map(&:to_sym))
  end

end

