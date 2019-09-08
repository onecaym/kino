require_relative '../lib/movie_collection'
require_relative '../lib/movie.rb'
require_relative '../lib/netflix.rb'
require_relative '../lib/theater.rb'
require_relative '../lib/halls.rb'
require_relative '../lib/periods.rb'
require_relative '../test/tmdb.rb'
require_relative '../bin/render.rb'
# require_relative '../test/web.haml'
require 'csv'
require 'money'
require 'haml'
movies = Kino::MovieCollection.new('../lib/movies.txt')
netflix = Kino::Netflix.new('../lib/movies.txt')
# theater = Kino::Theater.new('../lib/movies.txt')
# puts 'ALL'
# puts movies.all.first(0)
# puts 'SORTED'
# puts movies.sort_by(:name).first(1)
# puts 'FILTERED'
# puts 'STATS'
# puts movies.stats(:producer).first(0)
# puts 'Has Genre?'
# puts movies.all.first.year.class
#puts netflix.pay(2000)
# p netflix.show(genre: "Comedy")
# puts netflix.balance
# puts netflix.all.first
# puts movies.filter(period: :new)
# puts netflix.how_much?('The Shawshank Redemption')
# p theater.show(Time.new(2012, 10, 31, 15, 0).strftime("%H:%M"))
# puts theater.show(Time.new(2012, 10, 31, 5, 0).strftime("%H:%M"))
# puts theater.show(Time.new(2012, 10, 31, 9, 0).strftime("%H:%M"))
# p theater.show(Time.new(2012, 10, 31, 15, 0).strftime("%H:%M"))
# puts theater.show(Time.new(2012, 10, 31, 1, 0).strftime("%H:%M"))
# puts theater.when?("Castle in the Sky")
#puts theater.period
# puts theater.cash
# puts theater.add_money(500)
# puts theater.cash
# puts theater.take('Bank')
# puts theater.cash
# puts theater.buy_ticket("Castle in the Sky")
# puts theater.cash
# p theater.filter(name: "12 Angry Men")
# puts Kino::Netflix.take('Bank')
# puts Kino::Netflix.cash
# puts movies.map { |movie| movie.year}
# puts netflix.show { |movie| !movie.genre.include?('Terminator') && movie.genre.include?('Action') && movie.year > 2005}
# puts netflix.define_filter(:new) {|movie| movie.genre.include?("Action")}
# puts netflix.filter(new: true, year: 2005)
# puts netflix.filter(genre: "Sci-Fi")
# puts netflix.define_filter(:gt2010) {|movie| movie.year > 2011 }
# puts netflix.define_filter(:newest_sci_fi, from: :gt2010, arg: 2014)
# puts netflix.filter(newest_sci_fi: true)
# puts netflix.define_filter(:lt2012) {|movie| movie.year < 2013 && movie.genre.include?("Drama") }
# puts netflix.show(gt2010: true, lt2012: true)
# puts netflix.define_filter(:new) {|movie| movie.genre.include?("Action") && movie.year > 2014}
# puts netflix.show(new: true)
# puts netflix.show(genre: 'Drama')
# puts netflix.filter(gt2010: true, lt2012: true, country: 'USA')
# puts netflix.define_filter(:oldest) {|movie,year| movie.year < year}
# puts netflix.show(oldest: 1922)
# puts netflix.show(genre: 'Drama') {|movie| movie.name.include?('Amores Perros')}
# puts netflix.by_genre.sci_fi
#puts netflix.by_country.new_zealand
theater = Kino::Theater.new('../lib/movies.txt') do
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
      filters genre: ['Action', 'Drama'], year: 2007..Time.now.year
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
sav = movies.downloader
# sav.saver
# mov = Kino::MovieDB.new(movie_id)
# p mov
 # puts theater.show(Time.new(2012, 10, 31, 10, 0).strftime("%H:%M"),:green)
 # File.write('kino.html',"<H1><% film /%> </H1>")
# puts theater
  # puts theater.filter(genre: 'Comedy', year: 1900..1980)
  # puts theater.when?("Castle in the Sky")
#   theater = Kino::Theater.new('../lib/movies.txt') do
#     hall :red, title: 'Красный зал', places: 100
#     hall :blue, title: 'Синий зал', places: 50
#     hall :green, title: 'Зелёный зал (deluxe)', places: 12

#     period '09:00'..'11:00' do
#       description 'Утренний сеанс'
#       filters genre: 'Comedy', year: 1900..1980
#       price 10
#       hall :red, :blue
#     end

#     period '11:00'..'16:00' do
#       description 'Спецпоказ'
#       title 'The Terminator'
#       price 50
#       hall :green
#     end

#     period '16:00'..'20:00' do
#       description 'Вечерний сеанс'
#       filters genre: ['Action', 'Drama'], year: 2007..Time.now.year
#       price 20
#       hall :red, :blue
#     end

#     period '19:00'..'22:00' do
#       description 'Вечерний сеанс для киноманов'
#       filters year: 1900..1945, exclude_country: 'USA'
#       price 30
#       hall :green
#     end
# end