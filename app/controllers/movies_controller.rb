class MoviesController < ApplicationController
  def index
    result  = { movies: [], total_results: 0 }
    result  = ::MoviesClient.new.search(params['movie_name'], params[:page]) if params['movie_name'].present?
    @movies = Kaminari.paginate_array(result[:movies], total_count: result[:total_results] ).page(params[:page].to_i).per(20)
  end
end
