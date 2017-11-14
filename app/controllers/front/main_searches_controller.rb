class Front::MainSearchesController < FrontController
  def show
    @results = PgSearch.multisearch(params[:main_search][:query])
  end
end
