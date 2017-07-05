class Front::StaticPagesController < FrontController
  def home
  	@page_categories = PageCategory.all
    @posts = Post.order(published_at: :desc).last(9)
  end
end
