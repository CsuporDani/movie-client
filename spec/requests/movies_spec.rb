require 'rails_helper'

RSpec.describe "Movies", type: :request do
  include_context 'tmdp communicator search mock'

  describe "GET /" do
    context 'when no movie name given' do
      it 'sets @movies to empty array' do
        get '/'
        expect(assigns :movies).to be_empty
      end
    end

    context 'when movie name given' do
      it 'returns with right movies array' do
        get '/'
        expect(assigns :movies).to match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
      end
    end
  end
end
