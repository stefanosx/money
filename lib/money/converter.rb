class Money
  class Converter
    attr_reader :amount, :convert_from, :convert_to

    def initialize(amount, convert_from, convert_to)
      @amount = amount
      @convert_from = convert_from
      @convert_to = convert_to
    end

    # Convert method, Check if the convert_to currency is the same with
    # the base currency or if it is in the currency_rates hash, and make the 
    #  convert
    #
    #  Return [Money] Class
    def convert
      return Money.new(amount, convert_to) if convert_to == convert_from
      if convert_to == Money.base_currency
        rate = Money.currency_rates[convert_from]
        convert_amount = (amount.to_f/rate)
      else
        rate = Money.currency_rates[convert_to]
        convert_amount = amount.to_f * rate
      end
      Money.new(convert_amount, convert_to)
    end

  end
end
