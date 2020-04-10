#!/usr/bin/env ruby
require_relative '../kino/movie_collection.rb'
require 'haml'
require 'yaml'

module Kino
  class Renderer
    def initialize(collection)
      @movies = collection
      @directionweb = File.expand_path('../kino/templates/web.haml', __dir__)
      @directionyaml = File.expand_path('../kino/data/libs.yaml', __dir__)
      @directionlink = File.expand_path('./examples/movie.html', __dir__)
    end

    def start
      template = File.read(@directionweb)
      engine = Haml::Engine.new(template)
      yaml_lib = File.open(@directionyaml)

      yaml_lib.map { |film| film } || tmdb_load.load_m
      output = engine.render(Object.new, movies: @movies)
      File.write(@directionlink, output)
    end
  end
end
