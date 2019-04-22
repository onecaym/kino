require_relative './theater.rb'
module Kino
  class Period
    attr_reader :timerange
    def initialize(timerange, &block)
      @timerange = timerange
      instance_eval(&block)
    end

    def description(value)
      @per_description = value
    end

    def filters(value)
      @filters = value
    end

    def price(value)
      @price = value
    end

    def hall(*value)
      @hall = value
    end

    def title(value)
      @title = value
    end

    def to_s
      "Время: #{@timerange}
      Описание: #{@per_description}
      Кино: #{@filters.nil? ? @title : @filters}
      Цена: #{@price}
      Зал: #{@hall}"
    end

    def overlap?(some)
      @timerange.cover?(some.timerange.to_a.first) && (cur_hall & some.cur_hall).any?
    end

    def cur_hall
      @hall
    end

    def cur_filters
      @filters
    end
  end
end
