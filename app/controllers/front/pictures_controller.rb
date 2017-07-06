class Front::PicturesController < FrontController

  def index
    post_amount = Picture.all.count
    page_size = Rails.application.config.page_size
    @page = (params[:page] || 1).to_i
    @pages_total = post_amount / page_size
    if post_amount%page_size != 0
      @pages_total += 1
    end
    begin
      @pictures = Picture.paginate(page: params[:page], per_page: page_size)
    rescue
      @pictures = Picture.paginate(page: 1, per_page: page_size)
    end
  end
end
