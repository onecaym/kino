require 'classic_movie'
module Kino
  describe ClassicMovie do
    let(:movie) do
      { link: 'http://imdb.com/title/tt0043014/?ref_=chttp_tt_49',
        name: 'Sunset Blvd.',
        year: 1950,
        country: 'USA',
        date: '1950-08-25',
        genre: 'Drama',
        time: 110,
        rate: '8.5',
        producer: 'Billy Wilder',
        actors: 'William Holden,Gloria Swanson,Erich von Stroheim' }
    end

    let(:genres) do
      ['Action', 'Adventure', 'Animation',\
       'Biography', 'Comedy', 'Crime', 'Drama', 'Family',\
       'Fantasy', 'Film-Noir', 'History', 'Horror', 'Music',\
       'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Sport',\
       'Thriller', 'War', 'Western']
    end

    let(:bigcol) { MovieCollection.new('lib/movies.txt') }

    let(:classicmovie) { ClassicMovie.new(movie, genres, bigcol) }

    describe '.to_s' do
      it 'returns info about movie' do
        expect(classicmovie.to_s).to eq('Sunset Blvd. - классический фильм, режиссер Billy Wilder (еще 4 кино в списке)')
      end
    end
    describe 'cost' do
      it 'show us the cost of object' do
        expect(classicmovie.cost).to eq(1.5)
      end
    end
  end
end
