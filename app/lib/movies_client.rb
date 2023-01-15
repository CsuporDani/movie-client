##
# This class responsible to process movies list
class MoviesClient

  def search movie_name:, page: 1
    cache = Rails.cache.read([movie_name, page])
    cache ? fetch_from_cache(cache) : fetch_from_tmdb(movie_name, page)
  end

  private

  def fetch_from_cache cache
    CacheHitCount.find(cache[:cache_hit_count_id]).increment!(:hit_count)
    { total_results: cache[:total_results], movies: Movie.where(id: cache[:movie_ids]) }
  end

  def fetch_from_tmdb movie_name, page
    result = find_or_create(TmdbCommunicator::Search.instance.movie(movie_name, page))
    cached_hash = {
      movie_ids:          result[:movies].map(&:id),
      total_results:      result[:total_results],
      cache_hit_count_id: CacheHitCount.create(name: movie_name, page: page).id
    }
    Rails.cache.write([movie_name, page], cached_hash, expires_in: 2.minute)
    result
  end

  def find_or_create movies_hash
    movies_hash['results'].each_with_object({ total_results: movies_hash['total_results'], movies: [] }) do |movie_hash, memo|
      movie = Movie.find_or_initialize_by(tmdb_id: movie_hash['id'])
      movie.update!(movie_hash.slice('title', 'overview', 'poster_path'))
      memo[:movies] << movie
    end
  end

end