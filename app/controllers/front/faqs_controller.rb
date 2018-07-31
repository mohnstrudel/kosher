class Front::FaqsController < FrontController

  before_action :find_faq, only: [:show]

  def show

  end

  def index
    # Выбираем только те факи, где есть соответствующий перевод, 
    # иначе получаем пустые записи
    @faqs = Faq.with_translations(I18n.locale)

  end

  private

  def find_faq
    @faq = Faq.find(params[:id])
  end
end
