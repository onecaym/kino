require 'cashbox'
RSpec::Matchers.define_negated_matcher :not_change, :change
module Kino
  module Cashbox
    describe Cashbox do
      let(:inclass) { Class.new { include Cashbox } }
      let(:cashbox) { inclass.new }

      describe '.add_money' do
        context 'when amount is correct' do
          it 'adds cash' do
            expect { cashbox.add_money(500) }.to change { cashbox.cash.to_i }.from(0).to(5)
          end
        end
        context 'when amount incorrect' do
          it 'raise ArgumentError' do
            expect { cashbox.add_money(-100) }.to raise_error ArgumentError
          end
        end
      end

      describe '.take' do
        before { cashbox.add_money(200) }
        context 'when its a Bank' do
          it 'make cashbox empty' do
            expect { theater.take('Bank') }.to output('Проведена инкассация').to_stdout.and
            change { cashbox.cash }.to(0)
          end
        end
        context 'when its not a Bank' do
          it 'raises error' do
            expect { cashbox.take('Not a Bank') }.to
            raise_error(ArgumentError, 'Calling police...').and not_change { cashbox.cash }
          end
        end
      end
    end
  end
end
