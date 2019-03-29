require 'csv'
require_relative 'movie_collection.rb'
module Kino
  class Movie
    attr_reader :link, :name, :year, :country, :date, :genre, :time, :rate, :producer, :actors
    def initialize(movie_data, ginfo, bigcol) # rubocop:disable Metrics/AbcSize
      @link = movie_data[:link]
      @name = movie_data[:name]
      @year = movie_data[:year].to_i
      @country = movie_data[:country]
      @date = movie_data[:date]
      @genre = movie_data[:genre].split(',')
      @time = movie_data[:time].to_i
      @rate = movie_data[:rate]
      @producer = movie_data[:producer]
      @actors = movie_data[:actors].split(',')
      @information = ginfo
      @bigcol = bigcol
    end

    def matches?(head, value)
      (Array(send(head)) & Array(value)).any?
    end

    def has_genre?(genre) # rubocop:disable Naming/PredicateName
      raise 'This genre is not exist' unless @information.include?(genre)

      @genre.include?(genre)
    end

    def to_s
      "#{@name} (#{@year},#{@country})--#{@genre}--#{@time}"
    end

    def period
      self.class.to_s.chomp('Movie').downcase.to_sym
    end
  end
end
