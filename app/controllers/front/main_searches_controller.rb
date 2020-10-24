class Front::MainSearchesController < FrontController
  def show
    @results = PgSearch.multisearch(params[:main_search][:query]).to_a # convert to an array to enable sorting and grouping
    sorting_order = ["Product", "Manufacturer"]

    @results = @results.sort_by { |result| sorting_order.index result.searchable_type }
  end
end
