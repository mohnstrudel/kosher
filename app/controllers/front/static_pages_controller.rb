class Front::StaticPagesController < FrontController
  def home
  	@page_categories = PageCategory.all
  end
end
