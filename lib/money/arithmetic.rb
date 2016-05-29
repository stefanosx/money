class Money
  module Arithmetic
    def +(money)
      return self unless money.is_a?(Money)
      total_amount = money.convert_to(currency).amount + self.amount
      Money.new(total_amount, currency)
    end

    def -(money)
      return self unless money.is_a?(Money)
      total_amount = (self.amount - money.convert_to(currency).amount).abs
      Money.new(total_amount, currency)
    end

    # Multiply the model with the param, if the param is not numeric throws 
    # and error
    #
    # Params [multiplier<Numeric>], the multiplier
    #
    # Returns [Money<Class>, ArgumentError], Money class ot Argument Error
    def *(multiplier)
      if multiplier.is_a? Numeric
        Money.new(self.amount * multiplier, currency)
      else
        raise ArgumentError, "Can't be multiplied by a non numeric value"
      end
    end
    
    # Divide the model with the param, if the paras is not numeric and 
    # is < 0 the raise an Argument error
    #
    # Params [divider<Numeric>], the number to divide the object
    #
    # Returns [Money<Class>, ArgumentError], Money class ot Argument Error
    def /(divider)
      if divider.is_a? Numeric
        if divider > 0
          Money.new(self.amount / divider.to_f, currency)
        else
          raise ArgumentError, "Can't be divided by a value <= 0"
        end
      else
        raise ArgumentError, "Can't be divided by a non numeric value"
      end
    end
  end
end
