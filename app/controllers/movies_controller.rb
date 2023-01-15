class MoviesController < ApplicationController
  def index
    result  = { movies: [], total_results: 0 }
    result  = ::MoviesClient.new.search(**movie_params.to_h.symbolize_keys) if movie_params[:movie_name].present?
    @movies = Kaminari.paginate_array(result[:movies], total_count: result[:total_results]).page(movie_params[:page].to_i).per(20)
  end

  private

  def movie_params
    params.permit(:movie_name, :page)
  end
end
