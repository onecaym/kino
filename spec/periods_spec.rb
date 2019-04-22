require 'movie_collection'
require 'movie'
require 'theater'
require 'time'
require'periods'
module Kino
  describe Period do
    let(:period) { Period.new('09:00'..'11:00') { hall(:green) } }
    subject { period.overlap?(other_period) }
    context 'when nothing intersects' do
      let(:other_period) { Period.new('15:00'..'18:00') { hall(:yellow) } }
      it { is_expected.to eq false }
    end
    context 'when everything intersects' do
      let(:other_period) { Period.new('09:00'..'11:00') { hall(:green) } }
      it { is_expected.to eq true }
    end
    context 'when time intersects' do
      let(:other_period) { Period.new('09:00'..'11:00') { hall(:yellow) } }
      it { is_expected.to eq false }
    end
    context 'when hall intersects' do
      let(:other_period) { Period.new('15:00'..'18:00') { hall(:green) } }
      it { is_expected.to eq false }
    end
  end
end
