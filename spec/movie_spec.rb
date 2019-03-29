require 'ancient_movie'
require 'movie'
require 'movie_collection'
require 'csv'
module Kino
  describe Movie do
    let(:row) do
      { link: 'http://imdb.com/title/tt0071562/?ref_=chttp_tt_3',
        name: 'The Godfather: Part II',
        year: '1974',
        country: 'USA',
        date: '1974-12-20',
        genre: 'Drama',
        time: '200',
        rate: '9.1',
        producer: 'Francis Ford Coppola',
        actors: 'Al Pacino,Robert De Niro,Robert Duvall' }
    end

    let(:genres) do
      ['Action', 'Adventure', 'Animation',
       'Biography', 'Comedy', 'Crime', 'Drama', 'Family',
       'Fantasy', 'Film-Noir', 'History', 'Horror', 'Music',
       'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Sport',
       'Thriller', 'War', 'Western']
    end

    let(:bigcol) { MovieCollection.new('lib/movies.txt') }

    let(:movie) { Movie.new(row, genres, bigcol) }
    describe '.has_genre?' do
      context 'genre doesnt exist' do
        it 'returns RuntimeError' do
          expect { movie.has_genre?('Tradegy') }.to raise_error RuntimeError
        end
      end
      context 'genre exist' do
        it 'returns True' do
          expect(movie.has_genre?('Drama')).to eq(true)
        end
      end
      context 'genre exist but not this' do
        it 'returns False' do
          expect(movie.has_genre?('Comedy')).to eq(false)
        end
      end
    end
    describe '.matches?' do
      it 'returns true' do
        expect(movie.matches?(:genre, 'Drama')).to eq(true)
        expect(movie.matches?(:genre, %w[Comedy Drama])).to eq(true)
        expect(movie.matches?(:year, 1974)).to eq(true)
        expect(movie.matches?(:period, :future)).to eq(false)
      end
    end
    let(:movie) { Movie.new(row, genres, bigcol) }
    it 'returns class info' do
      expect(movie.link).to eq('http://imdb.com/title/tt0071562/?ref_=chttp_tt_3')
      expect(movie.name).to eq('The Godfather: Part II')
      expect(movie.year).to eq(1974)
      expect(movie.country).to eq('USA')
      expect(movie.date).to eq('1974-12-20')
      expect(movie.genre).to eq(['Drama'])
      expect(movie.time).to eq(200)
      expect(movie.rate).to eq('9.1')
      expect(movie.producer).to eq('Francis Ford Coppola')
      expect(movie.actors).to eq(['Al Pacino', 'Robert De Niro', 'Robert Duvall'])
    end
  end
end
