require 'movie_collection'
require 'movie'
require 'ancient_movie'
require 'classic_movie'
require 'modern_movie'
require 'new_movie'
module Kino
  describe MovieCollection do
    let(:movies) { MovieCollection.new('lib/movies.txt') }
    it 'Have to include a few classes' do
      expect(movies.filter(year: 1925)).to all(be_a(AncientMovie))
      expect(movies.filter(year: 1950)).to all(be_a(ClassicMovie))
      expect(movies.filter(year: 1999)).to all(be_a(ModernMovie))
      expect(movies.filter(year: 2012)).to all(be_a(NewMovie))
    end

    describe '.all' do
      context 'everything is correct' do
        it 'returns array' do
          expect(movies.all.count).to eq(250)
        end
      end
    end

    let(:sorted) { movies.sort_by(:date) }
    describe '.sort_by' do
      context 'everything is correct' do
        it 'returns array' do
          expect(sorted).to be_a(Array)
          expect(sorted.map(&:name).first(5)).to eq(['The Kid', 'The Gold Rush', 'The General', 'Metropolis', 'City Lights'])
          expect(sorted.count).to eq(250)
          expect(sorted).to all(be_a(Movie))
        end
      end
      context 'everything is incorrect' do
        it 'returns ArgumentError' do
          expect { movies.sort_by(:ddate) }.to raise_error(ArgumentError, 'Field ddate doesnt exist')
        end
      end
    end

    describe '.filter' do
      context 'everything id correct' do
        it 'returns array' do
          expect(movies.filter(genre: 'Comedy', country: 'USA').first(5)).to all(have_attributes(genre: include('Comedy'), country: 'USA'))
          expect(movies.filter(genre: 'Comedy').first(5)).to all(have_attributes(genre: include('Comedy')))
          expect(movies.filter(genre: 'Comedy')).not_to be_empty
        end
      end
      context 'everything is incorrect' do
        it 'returns ArgumentError' do
          expect { movies.filter(ggenre: 'Jango') }.to raise_error(ArgumentError, 'Field ggenre doesnt exist')
        end
      end
    end

    describe '.stats' do
      context 'everything is correct' do
        it 'returns array' do
          expect(movies.stats(:genre).first(5)).to eq(['Crime: 53', 'Drama: 166', 'Action: 34', 'Biography: 23', 'History: 14'])
        end
      end
      context 'everything is incorrect' do
        it 'returns ArgumentError' do
          expect { movies.stats(:aactors) }.to raise_error(ArgumentError, 'Field aactors doesnt exist')
        end
      end
    end
  end
end
