require_relative './theater.rb'
module Kino
  class Hall
    attr_reader :color, :title, :places

    def initialize(color, equip)
      @color = color
      @title = equip[:title]
      @places = equip[:places]
    end
  end
end