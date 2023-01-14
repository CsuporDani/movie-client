class MoviesController < ApplicationController
  def index
    result  = ::MoviesClient.new.search(params['movie_name'], params[:page]) if params['movie_name']
    @movies = Kaminari.paginate_array(result['results'], total_count: result['total_results'] ).page(params[:page]).per(20)
  end
end
