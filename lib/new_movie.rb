require_relative 'movie_collection.rb'
require_relative 'movie.rb'
require 'date'
require 'csv'
module Kino
  class NewMovie < Movie
    PRICE = 5
    def to_s
      "#{name} - новинка, вышло #{Time.now.strftime('%Y').to_i - year} лет назад"
    end

    def cost
      PRICE.to_f
    end
  end
end
