require_relative './theater.rb'
module Kino
  class Hall
    attr_reader :color, :title, :places

    def initialize(color, title:, places:)
      @color = color
      @title = title
      @places = places
    end
  end
end
