require './lib/downloader'
require 'themoviedb'
require 'dotenv/load'
require 'vcr'
describe Kino::Downloader do 
	let(:col) { Kino::MovieCollection.new('./lib/data/movies.txt') }
	let(:downloader) {Kino::Downloader.new(col)}
	let(:one) { [col.first] }
	let(:loader2) {Kino::Downloader.new(one)}

	describe '.start', :vcr do
		before {ENV['TMDBKEY']}
				subject { -> { loader2.start } }
		it { is_expected.to output("[\"tt0111161\", {:picture=>\"http://image.tmdb.org/t/p/w92/9O7gLzmreU0nGkIB6K3BsJbzvNv.jpg\", :translate=>\"Побег из Шоушенка\", :budget=>\"Budget:$25,000,000\\n            (estimated)\"}]\n").to_stdout }
	end
end