require_relative 'movie_collection.rb'
require_relative 'movie.rb'
require 'csv'
module Kino
  class ModernMovie < Movie
    PRICE = 3
    def to_s
      "#{name} - современное кино: играют #{actors.join(', ')}"
    end

    def cost
      PRICE.to_f
    end
  end
end
