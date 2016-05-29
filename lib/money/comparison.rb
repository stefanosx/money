class Money
  module Comparison
    
    def ==(money)
      return false unless money.is_a?(Money)
      self.amount == converted_money(money).amount
    end

    def >(money)
      return false unless money.is_a?(Money)
      self.amount > converted_money(money).amount
    end

    def <(money)
      return false unless money.is_a?(Money)
      self.amount < converted_money(money).amount
    end

    private

    def converted_money(money)
      money.convert_to(currency)
    end
  end
end
