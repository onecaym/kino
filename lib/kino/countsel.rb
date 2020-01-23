require_relative './netflix'

module Kino
  class Selectbycountry
    def initialize(netflix_col)
      @movies = netflix_col
    end

    def method_missing(meth)
      selection = @movies.select { |movie| movie.country.downcase == meth.to_s.tr('_', ' ') }
      !selection.empty? ? selection : super
    end

    def respond_to_missing?(meth)
      @movies.any? { |movie| movie.country.downcase == meth.to_s } ? true : super
    end
  end
end
