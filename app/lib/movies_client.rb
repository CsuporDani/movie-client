##
# This class responsible to process movies list
class MoviesClient
  def search movie_name, page
    TmdbCommunicator::Search.instance.movie(movie_name, page)
  end
end