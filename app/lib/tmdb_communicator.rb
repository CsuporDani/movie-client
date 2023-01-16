require 'singleton'

class TmdbCommunicator
  class ApiError < StandardError; end

  include Singleton

  attr_reader :host, :api_key

  def initialize
    @host    = 'api.themoviedb.org'
    @api_key = Rails.application.credentials.dig(:TMDB_API_KEY)
  end

  def get url
    response = HTTParty.get(url)
    raise response.code unless response.success?
    response
  rescue
    raise ApiError
  end
end