require 'yaml'
require './lib/downloader'
require 'themoviedb'
require 'dotenv/load'
require 'vcr'
describe Kino::Downloader do
  let(:col) { Kino::MovieCollection.new('./lib/data/movies.txt') }
  let(:downloader) { Kino::Downloader.new(col) }
  let(:one) { [col.first] }
  let(:loader2) { Kino::Downloader.new(one) }

  describe '.start', :vcr do
    before { ENV['TMDBKEY'] }
    subject { -> { loader2.start } }
    # subject { File.read('./lib/data/libs.yaml') }
    subject { YAML.load_file('./lib/data/libs.yaml') }
    it { expect(subject.count).to eq(250) }
    it { expect(subject['tt0111161']).to eq(budget: 25_000_000, picture: 'http://image.tmdb.org/t/p/w92/', translate: 'Побег из Шоушенка') }
  end
end
