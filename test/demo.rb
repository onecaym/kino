require_relative '../lib/movie_collection'
require_relative '../lib/movie.rb'
require_relative '../lib/netflix.rb'
require_relative '../lib/theater.rb'
require 'csv'
require 'money'
movies = Kino::MovieCollection.new('../lib/movies.txt')
netflix = Kino::Netflix.new('../lib/movies.txt')
theater = Kino::Theater.new('../lib/movies.txt')
#puts 'ALL'
#puts movies.all.first(0)
#puts 'SORTED'
#puts movies.sort_by(:name).first(1)
#puts 'FILTERED'
#puts 'STATS'
#puts movies.stats(:producer).first(0)
#puts 'Has Genre?'
#puts movies.all.first.year.class
puts netflix.pay(2000)
#p netflix.show(genre: "Comedy")
#puts netflix.balance
#puts netflix.all.first
#puts movies.filter(period: :new)
#puts netflix.how_much?('The Shawshank Redemption')
#p theater.show(Time.new(2012, 10, 31, 15, 0).strftime("%H:%M"))
#puts theater.show(Time.new(2012, 10, 31, 5, 0).strftime("%H:%M"))
#puts theater.show(Time.new(2012, 10, 31, 9, 0).strftime("%H:%M"))
#p theater.show(Time.new(2012, 10, 31, 15, 0).strftime("%H:%M"))
#puts theater.show(Time.new(2012, 10, 31, 1, 0).strftime("%H:%M"))
#puts theater.when?("Castle in the Sky")
#puts theater.money
#puts theater.cash
#puts theater.add_money(500)
#puts theater.cash
#puts theater.take('Bank')
#puts theater.cash
#puts theater.buy_ticket("Castle in the Sky")
#puts theater.cash
#p theater.filter(name: "12 Angry Men")
#puts Kino::Netflix.take('Bank')
#puts Kino::Netflix.cash
#puts movies.map { |movie| movie.year}
 puts netflix.show { |movie| !movie.genre.include?('Terminator') && movie.genre.include?('Action') && movie.year > 2005}
#puts netflix.define_filter(:new) {|movie| movie.genre.include?("Action")}
#puts netflix.filter(new: true, year: 2005)
#puts netflix.filter(year: 2000)
#puts netflix.define_filter(:gt2010) {|movie| movie.year > 2011 }
# puts netflix.define_filter(:newest_sci_fi, from: :gt2010, arg: 2014)
# puts netflix.filter(newest_sci_fi: true)
#puts netflix.define_filter(:lt2012) {|movie| movie.year < 2013 && movie.genre.include?("Drama") }
#puts netflix.show(gt2010: true, lt2012: true)
#puts netflix.define_filter(:new) {|movie| movie.genre.include?("Action") && movie.year > 2014}
#puts netflix.show(new: true)
#puts netflix.show(genre: 'Drama')
#puts netflix.filter(gt2010: true, lt2012: true, country: 'USA')
#puts netflix.define_filter(:oldest) {|movie,year| movie.year < year}
#puts netflix.show(oldest: 1922)
#puts netflix.show(genre: 'Drama') {|movie| movie.name.include?('Amores Perros')}