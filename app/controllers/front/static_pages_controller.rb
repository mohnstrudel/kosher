class Front::StaticPagesController < FrontController
  def home
  	@page_categories = PageCategory.all
    @posts = Post.active.includes(:translations).order(published_at: :desc).first(9)
  end

  def about
  end

  def contact
    @settings = GeneralSetting.first
    if @settings
      @long = @settings.long
      @lat = @settings.lat
      @title = @settings.title || ""
    end
  end

  def for_manufacturers
  end

  def for_consumers
  end
end
