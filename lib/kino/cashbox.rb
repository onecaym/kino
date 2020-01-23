require 'money'

module Kino
  module Cashbox
    Money.locale_backend = :currency
    def money
      @money ||= Money.new(0, 'USD')
    end

    def add_money(amount)
      raise ArgumentError if amount <= 0

      @money = money + Money.new(amount, 'USD')
    end

    def cash
      @money
    end

    def take(who)
      if who == 'Bank'
        @money = Money.new(0, 'USD')
        print 'Проведена инкассация'
      else
        call_police
        puts
        raise ArgumentError, 'Calling police...'
      end
    end

    def call_police
      print 'Police is on the way'
    end

    def netflix_wallet(money)
      @money + Money.new(money, 'USD')
    end
  end
end
