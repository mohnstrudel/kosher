class Front::PostsController < FrontController

  before_action :find_post, only: [:show]

  def show
    @post = Post.friendly.find(params[:id])
  end

  def index
    post_amount = Post.active.count
    page_size = Rails.application.config.page_size
    @page = (params[:page] || 1).to_i
    @pages_total = post_amount / page_size
    if post_amount%page_size != 0
      @pages_total += 1
    end

    begin
      @posts = Post.active.order(published_at: :desc).paginate(page: params[:page], per_page: page_size)
    rescue RangeError => e
      @posts = Post.active.order(published_at: :desc).paginate(page: 1, per_page: page_size)
      logger.debug e.message
    end
    
  end

  private

  def find_post
    # @post = Page.find(params[:id])
  end
end
