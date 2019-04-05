require_relative './theater.rb'
module Kino
  class Hall
    attr_reader :color, :title, :places

    def initialize(color, parametr)
      @color = color
      @title = parametr[:title]
      @places = parametr[:places]
    end
  end
end