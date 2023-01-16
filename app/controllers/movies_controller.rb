class MoviesController < ApplicationController

  rescue_from Exception,                   with: :exception_error
  rescue_from TmdbCommunicator::ApiError , with: :api_error

  before_action :clear_flash, only: [:index, :search]

  def index
    flash[:info] = 'All result from database'
    @movies = Movie.all.page(movie_params[:page].to_i).per(20)
  end

  def search
    result = if movie_params[:movie_name].present?
               res = ::MoviesClient.new.search(**movie_params.to_h.symbolize_keys) 
               flash[:info] = res[:message]
               res
             else
               flash[:danger] = 'No movie name has been given'
               { movies: [Movie.new(title: 'Request from the developer', poster_url: 'meme.jpg', overview: '')], total_results: 1 }
             end
    @movies = Kaminari.paginate_array(result[:movies], total_count: result[:total_results]).page(movie_params[:page].to_i).per(20)
    render 'index'
  end

  private

  def clear_flash
    flash.clear
  end
   
  def exception_error e
    puts e
    Rails.logger.error e.class.name
    Rails.logger.error e.message

    flash[:danger] = 'Something went wrong'
    render 'index'
  end

  def api_error e
    puts e
    Rails.logger.error e.class.name
    Rails.logger.error e.message

    flash[:danger] = 'Unable to connect to the remote server'
    render 'index'
  end

  def movie_params
    params.permit(:movie_name, :page)
  end
end
