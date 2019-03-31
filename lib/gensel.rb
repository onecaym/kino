require_relative './netflix'

module Kino
  class Selectbygenre
    def initialize(netflix_col)
      netflix_col.genrelist.each do |genre|
        define_singleton_method(genre.downcase.tr('-', '_')) do
          netflix_col.filter(genre: genre)
        end
      end
    end
  end
end
