require 'movie_collection'
require 'movie'
require 'theater'
require 'time'
module Kino
  describe Theater do
    let(:theater) do
      Theater.new('lib/movies.txt') do
        hall :red, title: 'Красный зал', places: 100
        hall :blue, title: 'Синий зал', places: 50
        hall :green, title: 'Зелёный зал (deluxe)', places: 12

        period '09:00'..'11:00' do
          description 'Утренний сеанс'
          filters genre: 'Comedy', year: 1900..1980
          price 10
          hall :red, :blue
        end

        period '11:00'..'16:00' do
          description 'Спецпоказ'
          title 'The Terminator'
          price 50
          hall :green
        end

        period '16:00'..'20:00' do
          description 'Вечерний сеанс'
          filters genre: %w[Action Drama], year: 2007..Time.now.year, title: 'Mad Max: Fury Road'
          price 20
          hall :red, :blue
        end

        period '19:00'..'22:00' do
          description 'Вечерний сеанс для киноманов'
          filters year: 1900..1945, exclude_country: 'USA', title: 'M'
          price 30
          hall :green
        end
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

    let(:theater2) do
      Theater.new('lib/movies.txt') do
        hall :red, title: 'Красный зал', places: 100
        hall :blue, title: 'Синий зал', places: 50
        hall :green, title: 'Зелёный зал (deluxe)', places: 12

        period '09:00'..'11:00' do
          description 'Утренний сеанс'
          filters genre: 'Comedy', year: 1900..1980
          price 10
          hall :green
        end

        period '11:00'..'16:00' do
          description 'Спецпоказ'
          title 'The Terminator'
          price 50
          hall :green
        end

        period '16:00'..'20:00' do
          description 'Вечерний сеанс'
          filters genre: %w[Action Drama], year: 2007..Time.now.year
          price 20
          hall :green
        end

        period '19:00'..'22:00' do
          description 'Вечерний сеанс для киноманов'
          filters year: 1900..1945, exclude_country: 'USA'
          price 30
          hall :green
        end
      end
    end
    describe 'valid?' do
      context 'when timetable correct' do
        it 'checks the timetable' do
          expect(theater.valid?).to be true
        end
      end
      context 'when timetable incorrect' do
        it 'checks the timetable' do
          expect(theater2.valid?).to be false
        end
      end
    end
  end
end
