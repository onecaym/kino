require_relative 'movie_collection.rb'
require_relative 'movie.rb'
require 'csv'
module Kino
  class AncientMovie < Movie
    PRICE = 1
    def to_s
      "#{name} - старый фильм (#{year})"
    end

    def cost
      PRICE.to_f
    end
  end
end
