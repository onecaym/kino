require 'ancient_movie'
module Kino
  describe AncientMovie do
    let(:movie) do
      { link: 'http://imdb.com/title/tt0071562/?ref_=chttp_tt_3',
        name: 'The Kid',
        year: 1925,
        country: 'USA',
        date: '1925-12-20',
        genre: 'Drama',
        time: 68,
        rate: '9.1',
        producer: 'Francis Ford Coppola',
        actors: 'Al Pacino,Robert De Niro,Robert Duvall' }
    end

    let(:genres) do
      ['Action', 'Adventure', 'Animation',\
       'Biography', 'Comedy', 'Crime', 'Drama', 'Family',\
       'Fantasy', 'Film-Noir', 'History', 'Horror', 'Music',\
       'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Sport',\
       'Thriller', 'War', 'Western']
    end

    let(:bigcol) { MovieCollection.new('lib/movies.txt') }

    let(:anmovie) { AncientMovie.new(movie, genres, bigcol) }

    describe '.to_s' do
      it 'returns info about movie' do
        expect(anmovie.to_s).to eq('The Kid - старый фильм (1925)')
      end
    end
    describe 'cost' do
      it 'show us the cost of object' do
        expect(anmovie.cost).to eq(1)
      end
    end
  end
end
