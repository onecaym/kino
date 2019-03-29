require 'movie_collection'
require 'movie'
require 'netflix'
module Kino
  describe Netflix do
    let(:netflix) { Netflix.new('lib/movies.txt') }
    let(:pay_500) { netflix.pay(500) }
    timenow = Time.now
    describe 'balance' do
      it 'shows netflix start balance' do
        expect(netflix.balance).to eq(0)
      end
    end
    describe '.show' do
      context 'arguments are true' do
        it 'shows a movie' do
          one = netflix.all.first
          timenow = Time.now
          expect { netflix.pay(10) }.to change { netflix.balance }.from(0).to(10.0)
          allow(netflix).to receive(:filter).and_return([one])
          expect { netflix.show(genre: 'Drama') }.to output("Now showing: The Shawshank Redemption (#{timenow.strftime('%H:%M')} -- #{(timenow + (142 * 60)).strftime('%H:%M')})\n").to_stdout
          expect(netflix.balance).to eq(7.0)
        end
      end
      context 'arguments are false' do
        it 'returns ArumentError' do
          expect { netflix.show(guenre: 'Tradegy').to raise_error(ArgumentError, 'This field doent exist') }
        end
      end
      context 'when with block' do
        it 'shows a film' do
          timenow = Time.now
          pay_500
          expect { netflix.show(genre: 'Drama') { |movie| movie.name.include?('Amores Perros') } }.to output("Now showing: Amores Perros (#{timenow.strftime('%H:%M')} -- #{(timenow + (154 * 60)).strftime('%H:%M')})\n").to_stdout
        end
      end
    end

    describe '.pay' do
      context 'arguments are true' do
        it 'increases my budget' do
          expect { netflix.pay(5) }.to change { netflix.balance }.from(0).to(5)
        end
      end
      context 'arguments are false' do
        it 'raises error' do
          expect { netflix.pay(-5) }.to raise_error(ArgumentError, 'cant be negative')
        end
      end
    end

    describe '.how_much?' do
      context 'movie name exist' do
        it 'returns cost' do
          expect(netflix.how_much?('The Shawshank Redemption').to_i).to be(3)
        end
      end
      context 'movie name doesnt exist' do
        it 'raises error' do
          expect { netflix.how_much?('simpsons') }.to raise_error(ArgumentError, 'This film doent exist')
        end
      end
    end

    describe '.define_filter' do
      before { netflix.pay(500) }

      context 'only block with true or false' do
        before { netflix.define_filter(:new) { |movie| movie.genre.include?('Action') && movie.year > 2014 } }
        subject { -> { netflix.show(new: true) } }
        it { is_expected.to output("Now showing: Mad Max: Fury Road (#{timenow.strftime('%H:%M')} -- #{(timenow + (120 * 60)).strftime('%H:%M')})\n").to_stdout }
      end

      context 'only block with arg instead of true or false' do
        before { netflix.define_filter(:oldest) { |movie, year| movie.year < year } }
        subject { -> { netflix.show(oldest: 1922) } }
        it { is_expected.to output("Now showing: The Kid (#{timenow.strftime('%H:%M')} -- #{(timenow + (68 * 60)).strftime('%H:%M')})\n").to_stdout }
      end

      context 'block with 2 filters' do
        before { netflix.define_filter(:gt2010) { |movie| movie.year > 2011 } }
        before { netflix.define_filter(:lt2012) { |movie| movie.year < 2013 && movie.genre.include?('Drama') } }
        subject { -> { netflix.show(gt2010: true, lt2012: true) } }
        it { is_expected.to output("Now showing: The Hunt (#{timenow.strftime('%H:%M')} -- #{(timenow + (115 * 60)).strftime('%H:%M')})\n").to_stdout }
      end
    end
  end
end
