class Front::FaqsController < FrontController

  before_action :find_faq, only: [:show]

  def show

  end

  def index
    @faqs = Faq.all

  end

  private

  def find_faq
    @faq = Faq.find(params[:id])
  end
end
