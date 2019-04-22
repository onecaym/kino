require_relative 'movie_collection.rb'
require_relative 'movie.rb'
require_relative './ancient_movie'
require_relative './classic_movie'
require_relative './modern_movie'
require_relative './new_movie'
require_relative './cashbox'
require_relative './halls'
require_relative './periods'
require 'csv'
require 'time'
module Kino
  class Theater < MovieCollection
    attr_reader :halls, :periods
    def initialize(col, &block)
      super
      @halls = []
      @periods = []
      instance_eval(&block)
    end
    include Cashbox
    TIME = { '05:00'..'11:59' => { period: :classic },
             '12:00'..'23:59' => { genre: %w[Comedy Adventure] },
             '00:00'..'04:59' => { genre: %w[Drama Horror] } }.freeze

    def mov(time, _hall)
      true_period = @periods.select { |per| per.timerange.cover?(time) }
      filter(true_period.first.cur_filters)
    end

    def show(time, hall)
      timenow = Time.now
      rand_movie = mov(time, hall).sample
      print "Now showing: #{rand_movie.name} (#{timenow.strftime('%H:%M')}"\
      " -- #{(timenow + (60 * rand_movie.time)).strftime('%H:%M')})"
    end

    def current_movie(filtered_films)
      filter(name: filtered_films)[0]
    end

    def when?(filtered_films)
      raise ArgumentError, 'This name is not exist' if filter(name: filtered_films).empty?

      print TIME.detect\
      { |_time, filters| filter(filters).any? { |f| f.name == filtered_films } }.first
    end

    def buy_ticket(movie)
      raise NameError, 'Такого фильма нет в прокате' if filter(name: movie).empty?

      add_money(filter(name: movie).first.cost * 100)
      print "Вы купили билет на #{movie}"
    end

    def hall(name, describ)
      @halls << Hall.new(name, describ)
    end

    def period(time, &block)
      @periods << Period.new(time, &block)
    end

    def valid?
      combine = @periods.combination(2)
      combine.none? { |first, second| first.overlap?(second) }
    end
  end
end
