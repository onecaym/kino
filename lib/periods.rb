require_relative './theater.rb'
module Kino
  class Period
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
      #{@per_description}
      Кино: #{@filters}
      Цена: #{@price}
      Зал: #{@hall}"
    end

    def alike
    	p @timerange.first
    end
  end
end