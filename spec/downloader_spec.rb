require './lib/downloader'
require 'vcr'
require 'rspec/its'
describe Kino::Downloader do 
	let(:col) { Kino::MovieCollection.new('./lib/data/movies.txt') }
	let(:downloader) {Kino::Downloader.new}
	let(:onemovie) {col.first}

	describe '.start', :vcr do
		
	end
end