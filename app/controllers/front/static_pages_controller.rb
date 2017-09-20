class Front::StaticPagesController < FrontController
  def home
  	@page_categories = PageCategory.all
    @posts = Post.includes(:translations).order(published_at: :desc).last(9)
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
