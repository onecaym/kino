require 'csv'
require_relative './ancient_movie'
require_relative './classic_movie'
require_relative './modern_movie'
require_relative './new_movie'
require_relative 'movie.rb'
module Kino
  class MovieCollection
    include Enumerable
    MOVIEFIELDS = %i[link name year country date genre time rate producer actors period].freeze # rubocop: disable Metrics/LineLength
    def initialize(collection_of_movies)
      collection_of_movies
      big_array = CSV.read(collection_of_movies, col_sep: '|', headers: MOVIEFIELDS) # rubocop: disable Metrics/LineLength
      genres = big_array[:genre].map { |x| x.split(',') }.flatten.uniq.sort
      @movies = big_array.map do |row|\
        case row[:year].to_i
        when 1900..1945
          Kino::AncientMovie.new(row, genres, self)
        when 1945..1968
          Kino::ClassicMovie.new(row, genres, self)
        when 1968..1999
          Kino::ModernMovie.new(row, genres, self)
        when 1999..2018
          Kino::NewMovie.new(row, genres, self)
        end
      end
    end

    # Выдает абсолютно все данные о каждом фильме
    # @example
    #  movies.each {|movie| movie }
    def each 
      @movies.each { |movie| yield movie }
    end

    # Выдает список всех фильмов из библиотеки
    # @example
    #   movies.all
    def all
      @movies
    end

    # Позволяет сортировать фильмы по выбранным параметрам
    # @example
    #   movies.sort_by(:name)
    def sort_by(value)
      raise ArgumentError, "Field #{value} doesnt exist" \
      unless MOVIEFIELDS.include? value

      @movies.sort_by { |x| x.send(value) }
    end

    # Проверочный метод для метода Filter. Выдает ошибку, в случае если используется несуществующий параметр в фильтрации
    # @return [Field 'param' doesnt exist]
    def filter_error(head)
      raise ArgumentError, "Field #{head} doesnt exist" \
          unless MOVIEFIELDS.include? head
    end

    # Позволяет выполнять более точную фильтрацию фильмов из бибилотеки
    # @example
    #  movies.filter(period: :new)
    def filter(type = nil, &block)
      if block_given?
        functional_filter(type, &block)
      else
        @movies.select do |movie|
          type.all? do |head, value|
            filter_error(head)
            movie.matches?(head, value)
          end
        end
      end
    end

     # По параметрам отображает статистику
     # @example
     #  movies.stats(:producer)
     def stats(header) # shows the stat
      raise ArgumentError, "Field #{header} doesnt exist" \
      unless MOVIEFIELDS.include? header

      @movies.map { |e| e.send(header) }
             .flatten.group_by { |x| x }
             .map { |head, value| "#{head}: #{value.count}" }
    end

    # Выдает список всех жанров фильмов из библиотеки
    def genrelist # shows all genres of library
      @movies.flat_map(&:genre).uniq
    end
  end
end
