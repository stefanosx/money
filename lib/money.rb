require 'money/converter'
require 'money/arithmetic'
require 'money/comparison'

class Money
  include Money::Arithmetic
  include Money::Comparison

  attr_reader :amount, :currency

  def initialize(amount, currency)
    @amount = amount.round(2)
    @currency = currency
  end

  def inspect
    ['%.2f' % amount, currency].join(" ")
  end

  # Converts this object to the selected currency
  #
  # Params [convert_currency<String>], currency 
  #
  # Returns [Money] Class
  def convert_to(convert_currency)
    Money::Converter.new(amount, currency, convert_currency).convert 
  end

  class << self

    attr_reader :base_currency, :currency_rates

    def conversion_rates(base_currency, currency_rates)
      @base_currency = base_currency
      @currency_rates = currency_rates
    end
  end

end
