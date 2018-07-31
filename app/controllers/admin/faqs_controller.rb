class Admin::FaqsController < AdminController
  
  include CrudConcern

  before_action :find_faq, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    @faqs = index_helper('Faq')
  end

  def new
    @faq = Faq.new
  end

  def create
    @faq = Faq.new(faq_params)
    create_helper(@faq, "edit_admin_faq_path")
  end

  def update
    update_helper(@faq, "edit_admin_faq_path", faq_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@faq, "admin_faqs_path")
  end

  private

  def find_faq
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(Faq.attribute_names.map(&:to_sym).push(Faq.globalize_attribute_names))
  end

end

