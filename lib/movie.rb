require 'csv'
require_relative 'movie_collection.rb'
require 'virtus'
require_relative '../test/tmdb.rb'
require 'nokogiri'
require 'open-uri'
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

    def movie_id
      link[22..30]
    end

    def picture
      picturelink(movie_id)
    end

    def budget
      filmbudget(movie_id)
    end

    def translate
      translation(movie_id)
    end

    def nokbudget
      page = Nokogiri::HTML(open(link.to_s)) # rubocop:disable Security/Open
      # p budget = page.css('div[id="titleDetails"]').css('div[class="txt-block"]')[6].text
      budget = page.at('div.txt-block:contains("Budget:")')
      if !budget.nil?
        budget.text.strip.sub(/Budget:/, '').sub(/[(]estimated[)]/, '')
      else
        'Неизвестно'
      end
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
