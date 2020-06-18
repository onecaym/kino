#!/usr/bin/env ruby
require_relative 'movie_collection.rb'
require 'themoviedb'
require 'dotenv/load'
require 'yaml'
require_relative '../lib/tmdb.rb'
require 'ruby-progressbar'

module Kino
  class Downloader
    def initialize(collection)
      @movies = collection
      @direction = File.expand_path('../lib/data/libs.yaml', __dir__)
    end

    def start
      extend MovieDB
      bar = ProgressBar.create(total: 250, :format => '%a %B %p%% %t')
      Tmdb::Api.key(ENV['TMDBKEY'])
      saved_info = @movies.map { |movie| bar.increment; [ movie.movie_id, { picture: movie.picturelink(movie.movie_id), translate: movie.translation(movie.movie_id), budget: movie.filmbudget(movie.link) }] }.to_h # rubocop:disable Metrics/LineLength
      File.write(@direction, saved_info.to_yaml)
    end
  end
end