#!/usr/bin/env ruby
require_relative '../lib/movie_collection.rb'
require 'haml'
require 'yaml'

module Kino
  movies = Kino::MovieCollection.new('../lib/movies.txt')
  template = File.read('../lib/templates/web.haml')
  engine = Haml::Engine.new(template)
   yaml_lib = File.open('../test/libs.yaml')

   def save_as
   	yaml_lib.map { |film| film} || tmdb_load.load_m 
	output = engine.render(Object.new, movies: movies)
	File.write('newcol.html', output)
   end

   if yaml_lib.any? == true
	yaml_lib.map { |film| film} || tmdb_load.load_m 
		output = engine.render(Object.new, movies: movies)
		File.write('newcol.html', output)
   else
   	puts 'downloading'
   	require_relative '../lib/downloader.rb'
   	load_mov = Downloader.new(movies)
   	yaml_lib.map { |film| film} || tmdb_load.load_m 
		output = engine.render(Object.new, movies: movies)
		File.write('newcol.html', output)
   end
end