##
# This class responsible to process movies list
class MoviesClient
  def search movie_name
    TmdbCommunicator::Search.instance.movie(movie_name)
  end
end

