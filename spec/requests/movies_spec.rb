require 'rails_helper'

RSpec.describe "Movies", type: :request do
  include_context 'http party mock'

  describe "GET /" do
    context 'when database empty' do
      it 'renders index' do
        get '/'

        expect(flash[:info]).to    eq 'All result from database'
        expect(assigns :movies).to be_empty
        expect(subject).to         render_template(:index)
      end
    end

    context 'when database is not empty' do
      let!(:movies) { (1..4).map {|index| Movie.create!(title: "Movie #{index}", tmdb_id: index, overview: '') } }

      it 'renders index and sets movies' do
        get '/'

        expect(flash[:info]).to    eq 'All result from database'
        expect(assigns :movies).to match_array(movies)
        expect(subject).to         render_template(:index)
      end
    end
  end


  describe "GET /search" do
    context 'when no movie title given' do
      it 'sets danger flash message' do
        get '/search'

        expect(flash[:danger]).to eq 'No movie name has been given'
        expect(subject).to        render_template(:index)
      end
    end

    context 'when movie title given' do
      context 'and cache is empty' do
        it 'sets info flash message and movies' do
          get('/search', params: { movie_name: 'Test' })

          expect(flash[:info]).to    eq 'Result from API'
          expect(assigns :movies).to match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
          expect(subject).to         render_template(:index)
        end
      end

      context 'and cache is not empty' do
        before(:each) {get('/search', params: { movie_name: 'Test' })}

        it 'sets info flash message and movies' do
          get('/search', params: { movie_name: 'Test' })

          expect(flash[:info]).to    eq 'Result from cache'
          expect(assigns :movies).to match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
          expect(subject).to         render_template(:index)
        end
      end
    end

    context 'when response is not succes' do
      let(:htpp_response_object) { Net::HTTPNotFound.new('1.1', 404, 'NOT FOUND')  }

      it 'sets danger flash message' do
        get('/search', params: { movie_name: 'Test' })

        expect(flash[:danger]).to eq '404 - NOT FOUND'
        expect(subject).to        render_template(:index)
      end
    end

    context 'when communicator error happend' do
      before(:each) { allow(HTTParty).to receive(:get).and_raise("error") }

      it 'sets danger flash message' do
        get('/search', params: { movie_name: 'Test' })

        expect(flash[:danger]).to eq 'Unable to connect to the remote server'
        expect(subject).to        render_template(:index)
      end
    end

    context 'when unexpected error raised' do
      before(:each) { allow_any_instance_of(MoviesClient).to receive(:search).and_raise("error") }

      it 'sets danger flash message' do
        get('/search', params: { movie_name: 'Test' })

        expect(flash[:danger]).to eq 'Something went wrong'
        expect(subject).to        render_template(:index)
      end
    end
  end
end
