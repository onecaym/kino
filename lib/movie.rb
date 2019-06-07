require 'csv'
require_relative 'movie_collection.rb'
require 'virtus'
require_relative '../test/tmdb.rb'
module Kino
  class Movie
    include Virtus.model


    class Minutes < Virtus::Attribute
      def coerce(value)
        value.to_i
      end
    end

    class StringArray < Virtus::Attribute
      def coerce(value)
        value.split(',').to_a
      end
    end

    attribute :link, String
    attribute :name, String
    attribute :year, Minutes
    attribute :country, String
    attribute :date, String
    attribute :genre, StringArray
    attribute :time, Minutes
    attribute :rate, String
    attribute :producer, String
    attribute :actors, StringArray
    def initialize(hash, ginfo, bigcol)
      super(hash)
      @information = ginfo
      @bigcol = bigcol
    end
    include MovieDB

    def picture
      picturelink(self.link[22..30])
    end

    def budget
      filmbudget(self.link[22..30])
    end

    def translate
      translation(self.link[22..30])
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
