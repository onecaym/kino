#!/usr/bin/env ruby
require_relative 'movie_collection.rb'
require 'themoviedb'
require 'dotenv/load'
require 'yaml'
require_relative '../test/tmdb.rb'

module Kino
	class Downloader
		movies = Kino::MovieCollection.new('../lib/movies.txt')
		include MovieDB
    	Tmdb::Api.key(ENV['TMDBKEY'])
		saved_info = movies.map {|movie| p [movie.movie_id, {picture: movie.picturelink(movie.movie_id), translate: movie.translation(movie.movie_id)}]}.to_h
		File.write('libs.yaml', saved_info.to_yaml)
	end
end
