require 'movie_collection'
require 'movie'
require 'theater'
require 'time'
module Kino
  describe Theater do
    let(:theater) do
      Theater.new('lib/movies.txt') do
        period '09:00'..'11:00' do
          hall :red, :blue
        end

        period '11:00'..'16:00' do
          hall :green
        end

        period '16:00'..'20:00' do
          hall :red, :blue
        end

        period '19:00'..'22:00' do
          hall :green
        end
      end
    end
    subject { timetable.valid? }
    describe 'valid?' do
      context 'when timetable correct' do
        let(:timetable) do
          Theater.new('lib/movies.txt') do
            period '09:00'..'11:00' do
              hall :green
            end

            period '11:00'..'16:00' do
              hall :green
            end

            period '16:00'..'20:00' do
              hall :green
            end

            period '19:00'..'22:00' do
              hall :green
            end
          end
        end
        it { is_expected.to eq false }
      end
      context 'when timetable incorrect' do
        let(:timetable) do
          Theater.new('lib/movies.txt') do
            period '09:00'..'11:00' do
              hall :red, :blue
            end

            period '11:00'..'16:00' do
              hall :green
            end

            period '16:00'..'20:00' do
              hall :red, :blue
            end

            period '19:00'..'22:00' do
              hall :green
            end
          end
        end
        it { is_expected.to eq true }
      end
    end

    describe 'show' do
      it 'returns a movie' do
        timenow = Time.now
        one = theater.filter(genre: 'Comedy', year: 1900..1980)[0]
        allow(theater).to receive(:filter).and_return([one])
        expect { theater.show(Time.new(2012, 10, 31, 10, 0).strftime('%H:%M'), :green) }.to output("Now showing: City Lights (#{timenow.strftime('%H:%M')} -- #{(timenow + (87 * 60)).strftime('%H:%M')})").to_stdout
      end
    end

    describe 'when?' do
      context 'correct movie name' do
        it 'returns movie time' do
          expect { theater.when?('Castle in the Sky') }.to output('12:00..23:59').to_stdout
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
