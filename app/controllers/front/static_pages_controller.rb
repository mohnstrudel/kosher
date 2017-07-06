class Front::StaticPagesController < FrontController
  def home
  	@page_categories = PageCategory.all
    @posts = Post.order(published_at: :desc).last(9)
  end

  def about
  end

  def contact
    @settings = GeneralSetting.first
  end

  def for_manufacturers
  end

  def for_consumers
  end
end
