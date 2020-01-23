require_relative 'movie_collection.rb'
require_relative 'movie.rb'
require 'csv'
module Kino
  class ClassicMovie < Movie
    PRICE = 1.5
    def to_s
      "#{name} - классический фильм, режиссер #{producer} (еще #{@bigcol.filter(producer: producer).count - 1} кино в списке)" # rubocop:disable Metrics/LineLength
    end

    def cost
      PRICE.to_f
    end
  end
end
