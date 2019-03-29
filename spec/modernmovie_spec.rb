require 'modern_movie'
module Kino
  describe ModernMovie do
    let(:movie) do
      { link: 'http://imdb.com/title/tt0137523/?ref_=chttp_tt_10',
        name: 'Fight Club',
        year: 1999,
        country: 'USA',
        date: '1999-10-15',
        genre: 'Drama',
        time: 139,
        rate: '8.9',
        producer: 'David Fincher',
        actors: 'Brad Pitt,Edward Norton,Helena Bonham Carter' }
    end

    let(:genres) do
      ['Action', 'Adventure', 'Animation',\
       'Biography', 'Comedy', 'Crime', 'Drama', 'Family',\
       'Fantasy', 'Film-Noir', 'History', 'Horror', 'Music',\
       'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Sport',\
       'Thriller', 'War', 'Western']
    end

    let(:bigcol) { MovieCollection.new('lib/movies.txt') }

    let(:modmovie) { ModernMovie.new(movie, genres, bigcol) }

    describe '.to_s' do
      it 'returns info about movie' do
        expect(modmovie.to_s).to eq('Fight Club - современное кино: играют Brad Pitt, Edward Norton, Helena Bonham Carter')
      end
    end
    describe 'cost' do
      it 'show us the cost of object' do
        expect(modmovie.cost).to eq(3)
      end
    end
  end
end
