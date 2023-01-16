require 'rails_helper'

RSpec.describe MoviesClient do
  include_context 'http party mock'

  subject { described_class.new }

  describe 'INSTANCE METHODS' do
    context "#search" do
      context 'when no movie_name given' do
        it 'raises ArgumentError' do
          expect { subject.search }.to raise_error(ArgumentError, 'missing keyword: :movie_name')
        end
      end

      context 'when no page given' do
        let(:movie_name) { 'Test Movie' }

        it 'reades rails cache whit right attributes' do
          expect(Rails.cache).to receive(:read).with([movie_name, 1])
          subject.search(movie_name: movie_name)
        end

        it 'calls fetc_from_tmdb if cache not available' do
          expect(subject).to receive(:fetch_from_tmdb).with(movie_name, 1).and_call_original
          resp = subject.search(movie_name: movie_name)
          expect(resp[:total_results]).to eq(mocked_answer['total_results'])
          expect(resp[:movies]).to        match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
        end

        it 'calls fetc_from_tmdb if cache outdated' do
          subject.search(movie_name: movie_name)
          expect(subject).to receive(:fetch_from_tmdb).with(movie_name, 1).and_call_original
          Timecop.freeze(3.minutes.from_now) do
            resp = subject.search(movie_name: movie_name)
            expect(resp[:total_results]).to eq(mocked_answer['total_results'])
            expect(resp[:movies]).to        match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
          end
        end

        it 'calls fetc_from_tmdb if cache outdated' do
          subject.search(movie_name: movie_name)
          expect(subject).to receive(:fetch_from_cache).and_call_original
          resp = subject.search(movie_name: movie_name)

          expect(resp[:total_results]).to eq(mocked_answer['total_results'])
          expect(resp[:movies]).to        match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
        end
      end

      context 'when page given' do
        let(:movie_name) { 'Test Movie' }
        let(:page)       { 2 }

        it 'reades rails cache whit right attributes' do
          expect(Rails.cache).to receive(:read).with([movie_name, page])
          subject.search(movie_name: movie_name, page: page)
        end

        it 'calls fetc_from_tmdb if cache not available' do
          expect(subject).to receive(:fetch_from_tmdb).with(movie_name, page).and_call_original
          resp = subject.search(movie_name: movie_name, page: page)
          expect(resp[:total_results]).to eq(mocked_answer['total_results'])
          expect(resp[:movies]).to        match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
        end

        it 'calls fetc_from_tmdb if cache outdated' do
          subject.search(movie_name: movie_name, page: page)
          expect(subject).to receive(:fetch_from_tmdb).with(movie_name, page).and_call_original
          Timecop.freeze(3.minutes.from_now) do
            resp = subject.search(movie_name: movie_name, page: page)
            expect(resp[:total_results]).to eq(mocked_answer['total_results'])
            expect(resp[:movies]).to        match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
          end
        end
      end
    end

    context '#fetch_from_cache' do
      let(:movie_name) { 'Test Movie' }
      let(:page)       { 1 }

      before(:each) do
        subject.search(movie_name: movie_name, page: page)
      end

      it 'returns with right data' do
        resp = subject.send(:fetch_from_cache, Rails.cache.read([movie_name, page]))

        expect(resp[:message]).to       eq('Result from cache')
        expect(resp[:total_results]).to eq(mocked_answer['total_results'])
        expect(resp[:movies]).to        match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
      end
    end

    context '#fetch_from_tmdb' do
      let(:movie_name) { 'Test Movie' }
      let(:page)       { 1 }
      
      it 'returns with right data' do
        resp = subject.send(:fetch_from_tmdb, movie_name, page)

        expect(resp[:message]).to       eq('Result from API')
        expect(resp[:total_results]).to eq(mocked_answer['total_results'])
        expect(resp[:movies]).to        match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
      end
    end

    context '#find_or_create_movies' do
      it 'returns with right records' do
        resp = subject.send(:find_or_create_movies, mocked_answer)

        expect(resp).to match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
      end
    end

    context '#process_response ' do
      it 'returns with right records' do
        resp = subject.send(:process_response , mocked_answer)

        expect(resp[:message]).to       eq('Result from API')
        expect(resp[:total_results]).to eq(mocked_answer['total_results'])
        expect(resp[:movies]).to        match_array(Movie.where(tmdb_id: mocked_answer['results'].map { |r| r['id'] }))
      end
    end
  end
end
