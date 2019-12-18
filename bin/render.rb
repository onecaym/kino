#!/usr/bin/env ruby
require_relative '../lib/movie_collection.rb'
require_relative '../lib/renderer.rb'
require_relative '../lib/downloader.rb'
require 'haml'
require 'yaml'

yaml_lib = File.open('../lib/data/libs.yaml')
unless yaml_lib.any?
  loader = Kino::Downloader.new
  loader.start
end
loader = Kino::Downloader.new(Kino::MovieCollection.new('../lib/data/movies.txt'))
  loader.start
  rend = Kino::Renderer.new
  rend.start