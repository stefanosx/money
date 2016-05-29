require 'test_helper'

describe 'money' do
  before do
    @rates = {"USD" => 1.11, "Bitcoin" => 0.004}
    Money.conversion_rates("EUR", @rates)
  end

  it 'has conversion rates' do
    assert_equal "EUR", Money.base_currency
    assert_equal @rates, Money.currency_rates
  end
  
  it 'has amount and currency' do
    money = Money.new(30, "EUR")
    assert_equal 30, money.amount 
    assert_equal "EUR", money.currency
  end

  describe 'converts' do
    before do
      @fifty_eur = Money.new(50, "EUR")
      @fifty_usd = Money.new(50, "USD")
    end
   
    it 'from EUR to USD' do
      usd = @fifty_eur.convert_to("USD")
      assert_equal usd.currency, "USD"
      assert_equal 55.50, usd.amount
      assert_equal "55.50 USD", usd.inspect
    end

    it 'from USD to EUR' do
      eur = @fifty_usd.convert_to("EUR")
      assert_equal eur.currency, "EUR"
      assert_equal 45.05, eur.amount
      assert_equal "45.05 EUR", eur.inspect
    end

  end

  describe "arithmetic operations" do
    before do
      @twenty_eur = Money.new(20, "EUR")
    end
    describe "addition" do
      it "same currency" do
        ten_eur = Money.new(10, "EUR")
        thirty_eur = @twenty_eur + ten_eur 
        assert_equal "30.00 EUR", thirty_eur.inspect
      end

      it "different currency" do
        ten_usd = Money.new(10, "USD")
        thirty_eur = @twenty_eur + ten_usd
        assert_equal "29.01 EUR", thirty_eur.inspect
      end

      it "return the first currency of the add" do
        ten_usd = Money.new(10, "USD")
        thirty_eur = ten_usd + @twenty_eur
        assert_equal "32.20 USD", thirty_eur.inspect
      end
    end
    
    describe "subtraction" do
      it "same currency" do
        ten_eur = Money.new(10, "EUR")
        thirty_eur = @twenty_eur - ten_eur 
        assert_equal "10.00 EUR", thirty_eur.inspect
      end

      it "different currency" do
        ten_usd = Money.new(10, "USD")
        thirty_eur = @twenty_eur - ten_usd
        assert_equal "10.99 EUR", thirty_eur.inspect
      end
    end

    describe "multiplication" do
      it "multiply with number" do
        assert_equal 60, (@twenty_eur * 3).amount
      end
    end

    describe "division" do
      it "divide with number" do
        assert_equal 10, (@twenty_eur / 2).amount
      end

      it "through error when value is negative or zero" do
        assert_raises ArgumentError do
          @twenty_eur / 0
        end
      end
    end
  end

  describe 'comparison operations' do
    before do
      @twenty_eur = Money.new(20, "EUR")
    end

    it 'returns false if argument is not money object' do
      assert_equal false, @twenty_eur == 20
    end

    it 'check if 2 Money models is equal' do
      assert_equal true,  @twenty_eur == Money.new(20, "EUR")
    end

    it "returns false if not equal" do
      assert_equal false, @twenty_eur == Money.new(20, "USD") 
    end

    it "returns equal in different currency" do
      assert_equal true, Money.new(50, "EUR") == Money.new(55.5, "USD")
    end
  
    it 'returns true if 20 EUR is bigger that 20 USD' do
      assert_equal true, @twenty_eur > Money.new(20, "USD")
    end

    it "returns true if 50 eur is biger than 20 eur" do
      assert_equal true, @twenty_eur < Money.new(50, "EUR")
    end
  end
end
