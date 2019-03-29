require_relative 'movie_collection.rb'
require_relative 'movie.rb'
require_relative './ancient_movie'
require_relative './classic_movie'
require_relative './modern_movie'
require_relative './new_movie'
require 'csv'
require 'time'
require_relative './cashbox'
module Kino
  class Netflix < MovieCollection
    extend Cashbox
    def initialize(collection_of_movies)
      super
      @balance = 0
    end

    attr_reader :balance

    def pay(cash_value)
      raise ArgumentError, 'cant be negative' unless cash_value > 0

      @balance = cash_value
      Netflix.add_money(cash_value)
      "Вы положили #{cash_value}$ на свой счет"
    end

    def paying_process(movie)
      raise 'Not enough money' unless @balance - movie.cost > 0

      @balance -= movie.cost
    end

    def functional_filter(_object)
      @movies.select do |param|
        yield(param) if block_given?
      end
    end

    def define_filter(key, from: nil, arg: nil, &block)
      @filters ||= {}
      @filters[key] = if from.nil?
                        block
                      else
                        ->(movie) { @filters[from].call(movie, arg) }
                      end
    end

    def filter(type)
      if type.nil?
        @movies.select { |movie| yield(movie) }
      else
        internal_filters = type.select { |key, _val| MOVIEFIELDS.include?(key) }
        custom_filters = type.reject { |key, _val| MOVIEFIELDS.include?(key) }
        filtered_objects = internal_filters.empty? ? @movies : super(internal_filters)
        custom_filters.reduce(filtered_objects) do |res, (key, val)|
          res.select do |movie|
            if val == true
              @filters[key].call(movie)
            else
              @filters[key].call(movie, val)
            end
          end
        end
      end
    end

    def show_from_block(wish, &block)
      timenow = Time.now
      blockmovie = filter(wish, &block).sample
      puts "Now showing: #{blockmovie.name} (#{timenow.strftime('%H:%M')}\
       -- #{(timenow + (60 * blockmovie.time)).strftime('%H:%M')})"
    end

    def show_without_block(wish)
      timenow = Time.now
      movie = filter(wish).sample
      paying_process(movie)
      puts "Now showing: #{movie.name} (#{timenow.strftime('%H:%M')}\
       -- #{(timenow + (60 * movie.time)).strftime('%H:%M')})"
    end

    def show(wish = nil, &block)
      if block_given?
        show_from_block(wish, &block)
      else
        raise ArgumentError, 'This field doesnt exist' if filter(wish).empty?

        show_without_block(wish, &block)
      end
    end

    def how_much?(one_movie)
      raise ArgumentError, 'This film doent exist' \
      if filter(name: one_movie).empty?

      filter(name: one_movie).first.cost
    end
  end
end
