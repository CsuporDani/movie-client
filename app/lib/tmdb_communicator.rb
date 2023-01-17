require 'singleton'

class TmdbCommunicator
  class ApiError < StandardError; end
  class BadResponse < StandardError; end

  include Singleton

  attr_reader :host, :api_key

  def initialize
    @host    = 'api.themoviedb.org'
    @api_key = Rails.application.credentials.dig(:TMDB_API_KEY)
  end

  def get url
    response = HTTParty.get(url)
    raise TmdbCommunicator::BadResponse.new "#{response.code} - #{response.message}" unless response.success?
    response
  rescue TmdbCommunicator::BadResponse => e
    raise e
  rescue => e
    raise ApiError.new e.message
  end
end