##
# This class responsible to process movies list
class MoviesClient
  def search movie_name, page=1
    find_or_create(TmdbCommunicator::Search.instance.movie(movie_name, page))
  end

  def find_or_create movies_hash
    movies_hash['results'].inject({total_results: movies_hash['total_results'], movies: []}) do |memo, movie_hash|
      movie = Movie.find_or_initialize_by(tmdb_id: movie_hash['id'])
      movie.attributes = (movie_hash.slice('title', 'overview', 'poster_path'))
      movie.save!
      memo[:movies] << movie
      memo
    end
  end
end