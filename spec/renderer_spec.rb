require './lib/renderer'
require 'themoviedb'
require 'haml'
require 'dotenv/load'
require 'vcr'
describe Kino::Renderer do
	let(:col) {Kino::MovieCollection.new('./lib/data/movies.txt') }
	let(:one) { [col.first] }
	let(:renderer) {Kino::Renderer.new(one)}

	describe '.start' do
		before { renderer.start }
		subject { File.read('./test/MovieBase.html') }
		it { expect(subject).to include("<td>The Shawshank Redemption (Побег из Шоушенка)</td>") }
	end
end