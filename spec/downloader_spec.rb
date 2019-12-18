require './lib/downloader'
require 'vcr'
require 'rspec/its'
require 'dotenv/load'
describe Kino::Downloader do 
	let(:col) { Kino::MovieCollection.new('./lib/data/movies.txt') }
	let(:downloader) {Kino::Downloader.new(col)}
	let(:key) {Tmdb::Api.key(ENV['TMDBKEY'])}


	describe '.start', :vcr do
		subject { -> { downloader.start } }
		it { is_expected.to output("d").to_stdout }
	end
end