#!/usr/bin/env ruby
require_relative 'movie_collection.rb'
require 'themoviedb'
require 'dotenv/load'
require 'yaml'
require_relative '../lib/tmdb.rb'
require 'progress_bar'

module Kino
	class Downloader
		movies = Kino::MovieCollection.new('../lib/movies.txt')
		include MovieDB
    	Tmdb::Api.key(ENV['TMDBKEY'])
		saved_info = movies.map  {|movie| p [movie.movie_id, { picture: movie.picturelink(movie.movie_id), translate: movie.translation(movie.movie_id), budget: movie.filmbudget(movie.link)}]}.to_h
		p saved_info
		File.write('libs.yaml', saved_info.to_yaml)
	end
end