require_relative 'movie_collection.rb'
require_relative 'movie.rb'
require_relative './ancient_movie'
require_relative './classic_movie'
require_relative './modern_movie'
require_relative './new_movie'
require_relative './cashbox'
require_relative './kinoteatr'
require 'csv'
require 'time'
module Kino
  class Theater < MovieCollection
    def initialize(&block)
      @halls = []
      instance_eval(&block)
    end
    include Cashbox
    TIME = { '05:00'..'11:59' => { period: :classic },
             '12:00'..'23:59' => { genre: %w[Comedy Adventure] },
             '00:00'..'04:59' => { genre: %w[Drama Horror] } }.freeze

    def show(filtered_films)
      movie = filter(TIME.select { |daytime| daytime.cover? filtered_films }.values.first).sample
      timenow = Time.now
      start = timenow.strftime('%H:%M')
      "Now showing: #{movie.name} (#{start} -" \
        "- #{(timenow + (60 * movie.time)).strftime('%H:%M')})"
    end

    def current_movie(filtered_films)
      filter(name: filtered_films)[0]
    end

    def when?(filtered_films)
      raise ArgumentError, 'This name is not exist' if filter(name: filtered_films).empty?

      TIME.detect { |_time, filters| filter(filters).any? { |f| f.name == filtered_films } }.first
    end

    def buy_ticket(movie)
      raise NameError, 'Такого фильма нет в прокате' if filter(name: movie).empty?

      add_money(filter(name: movie).first.cost * 100)
      puts "Вы купили билет на #{movie}"
    end

    def halls(color, equip)
      @halls << Hall.new(equip)
    end
  end
end
