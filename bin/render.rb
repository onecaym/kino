#!/usr/bin/env ruby
require_relative '../lib/movie_collection.rb'
require_relative '../lib/renderer.rb'
require_relative '../lib/downloader.rb'
require 'haml'
require 'yaml'

yaml_lib = File.open('../lib/data/libs.yaml')
collection = Kino::MovieCollection.new('../lib/data/movies.txt')
puts yaml_lib.any?
unless yaml_lib.any?
  loader = Kino::Downloader.new(collection)
  loader.start
end
loader = Kino::Downloader.new(collection)
  loader.start
rend = Kino::Renderer.new(collection)
rend.start
