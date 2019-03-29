require 'new_movie'
module Kino
  describe NewMovie do
    let(:movie) do
      { link: 'http://imdb.com/title/tt1853728/?ref_=chttp_tt_59',
        name: 'Django Unchained',
        year: 2012,
        country: 'USA',
        date: '2012-12-25',
        genre: 'Western',
        time: 165,
        rate: '8.5',
        producer: 'Quentin Tarantino',
        actors: 'Jamie Foxx,Christoph Waltz,Leonardo DiCaprio' }
    end

    let(:genres) do
      ['Action', 'Adventure', 'Animation',\
       'Biography', 'Comedy', 'Crime', 'Drama', 'Family',\
       'Fantasy', 'Film-Noir', 'History', 'Horror', 'Music',\
       'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Sport',\
       'Thriller', 'War', 'Western']
    end

    let(:bigcol) { MovieCollection.new('lib/movies.txt') }

    let(:nmovie) { NewMovie.new(movie, genres, bigcol) }

    describe '.to_s' do
      it 'returns info about movie' do
        expect(nmovie.to_s).to eq('Django Unchained - новинка, вышло 6 лет назад')
      end
    end
    describe 'cost' do
      it 'show us the cost of object' do
        expect(nmovie.cost).to eq(5)
      end
    end
  end
end
