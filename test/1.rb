require 'virtus'
class Test
  include Virtus.model

  attribute :name, String
  attribute :age, Integer
  attribute :height, Float
end

gg =  Test.new(name: 'Vasya', age: '15', height: '1.84')
p gg
gg =  Test.new(limk: 'l', name: 'ex', year: 2010, country: 'USA', date: '01', genre: 'sring', time: 20, rate: '10', producer: 'al', actors: 'ss')