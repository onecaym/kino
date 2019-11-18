#!/usr/bin/env ruby
require_relative '../lib/movie_collection.rb'
require 'haml'
require 'yaml'

module Kino
	class Renderer
		def start
			movies = Kino::MovieCollection.new('../lib/data/movies.txt')
	  template = File.read('../lib/templates/web.haml')
	  engine = Haml::Engine.new(template)
	   yaml_lib = File.open('../lib/data/libs.yaml')

		yaml_lib.map { |film| film} || tmdb_load.load_m 
			output = engine.render(Object.new, movies: movies)
			File.write('../test/MovieBase.html', output)
		end
	end
end