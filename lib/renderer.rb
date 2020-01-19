#!/usr/bin/env ruby
require_relative '../lib/movie_collection.rb'
require 'haml'
require 'yaml'

module Kino
	class Renderer
		def initialize(collection)
			@movies = collection
		end
		def start
			directionweb = File.expand_path('../lib/templates/web.haml', __dir__)
	  template = File.read(directionweb)
	  engine = Haml::Engine.new(template)
	  directionyaml = File.expand_path('../lib/data/libs.yaml', __dir__)
	   yaml_lib = File.open(directionyaml)

		yaml_lib.map { |film| film} || tmdb_load.load_m 
			output = engine.render(Object.new, movies: @movies)
			directionlink = File.expand_path('../test/MovieBase.html', __dir__)
			File.write(directionlink, output)
		end
	end
end