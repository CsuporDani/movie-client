class TmdbCommunicator::Search < TmdbCommunicator


  def movie movie_name, page
    query = { api_key:api_key, query: movie_name, page: page }.to_query
    path  = '/3/search/movie'
    get(URI::HTTPS.build(host: host, path: path, query: query))
  end

end