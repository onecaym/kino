#!/usr/bin/env ruby
require 'slop'
require_relative '../lib/kino.rb'

opts = Slop.parse do |o|
	o.integer '--pay', 'money'
  o.string '--show', 'show'
end

money_amount = opts[:pay]
filter = opts[:show]

key, value = filter.split(':')
key = key.to_sym

fil = Hash[key, value]

netflix = Kino::Netflix.new('../lib/kino/data/movies.txt')
netflix.pay(money_amount)
netflix.show(fil)