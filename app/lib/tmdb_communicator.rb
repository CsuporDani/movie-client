require 'singleton'

class TmdbCommunicator
  include Singleton

  def get url
    HTTParty.get(url)
  end

  def host
    'api.themoviedb.org'
  end

  def api_key
    Rails.application.credentials.dig(:TMDB_API_KEY)
  end
end