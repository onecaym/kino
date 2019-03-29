require 'movie_collection'
require 'movie'
require 'theater'
require 'time'
module Kino
  describe Theater do
    let(:theater) { Theater.new('lib/movies.txt') }
    describe 'show' do
      it 'returns a movie' do
        one = theater.filter(period: :classic)[0]
        allow(theater).to receive(:filter).and_return([one])
        timenow = Time.now
        expect(theater.show(Time.new(2012, 10, 31, 9, 0).strftime('%H:%M'))).to eq("Now showing: 12 Angry Men (#{timenow.strftime('%H:%M')} -- #{(timenow + (96 * 60)).strftime('%H:%M')})")
      end
    end
    describe 'when?' do
      context 'correct movie name' do
        it 'returns time' do
          expect(theater.when?('12 Angry Men')).to eq('05:00'..'11:59')
        end
      end
      context 'incorrect movie name' do
        it 'returns Argument Error' do
          expect { theater.when?('Simpsons') }.to raise_error(ArgumentError, 'This name is not exist')
        end
      end
    end
  end
end
