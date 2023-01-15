require 'singleton'

class TmdbCommunicator
  include Singleton

  attr_reader :host, :api_key

  def initialize
    @host    = 'api.themoviedb.org'
    @api_key = Rails.application.credentials.dig(:TMDB_API_KEY)
  end

  def get url
    HTTParty.get(url)
  end
end