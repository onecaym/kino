#!/usr/bin/env ruby
require_relative '../lib/movie_collection.rb'
require 'haml'
require 'yaml'

module Kino
yaml_lib = File.open('../lib/libs.yaml')
unless yaml_lib.any?
  puts '1'
  require_relative '../lib/downloader.rb'
  Downloader.new
end
puts '2'
require_relative '../lib/renderer.rb'
  Renderer.new

end