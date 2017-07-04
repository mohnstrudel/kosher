class Front::StaticPagesController < FrontController
  def home
  	@page_categories = PageCategory.all
    @posts = Post.last(9)
  end
end
