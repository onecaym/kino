require 'themoviedb'
require 'dotenv/load'
require 'yaml'
require_relative 'movie_collection.rb'

module Kino
	class Downloader
		def initialize(movies)
			@movies = movies
			Tmdb::Api.key(ENV['TMDBKEY'])
		end

		def saver
			saved_info = @movies.map {|movie| p [movie.movie_id, {picture: movie.picture, translate: movie.translate, budget: movie.nokbudget}]}.to_h
			File.write('libs.yaml', saved_info.to_yaml)
		end
	end
end
