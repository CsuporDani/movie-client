require 'rails_helper'

RSpec.describe TmdbCommunicator::Search do
  subject { described_class.instance }

  describe 'INSTANCE METHODS' do
    context "#movie" do
      let(:movie_name) { 'Test' }
      let(:page)       { 1 }

      it 'creates right url' do
        query = { api_key: subject.api_key, query: movie_name, page: page }.to_query
        path  = '/3/search/movie'

        expect(subject).to receive(:get).with( URI::HTTPS.build(host: subject.host, path: path, query: query))
        subject.movie(movie_name, page)
      end
    end
  end
end