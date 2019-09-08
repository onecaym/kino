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

    def each
      @movies.each { |movie| yield movie }
    end

    def all
      @movies
    end

    def sort_by(value)
      raise ArgumentError, "Field #{value} doesnt exist" \
      unless MOVIEFIELDS.include? value

      @movies.sort_by { |x| x.send(value) }
    end

    def filter_error(head)
      raise ArgumentError, "Field #{head} doesnt exist" \
          unless MOVIEFIELDS.include? head
    end

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

    def stats(header)
      raise ArgumentError, "Field #{header} doesnt exist" \
      unless MOVIEFIELDS.include? header

      @movies.map { |e| e.send(header) }
             .flatten.group_by { |x| x }
             .map { |head, value| "#{head}: #{value.count}" }
    end

    def genrelist
      @movies.flat_map(&:genre).uniq
    end
  end
end
