require 'test/unit'


class MainTest < Test::Unit::TestCase

  def test_calculator
    assert_equal 0, Calculator.add("")
    assert_equal 1, Calculator.add( "1")
    assert_equal 4, Calculator.add( "1,3")
    assert_equal 5, Calculator.add( "1,3, 1")
    assert_equal 4, Calculator.add( "1\n3")
    assert_equal 6, Calculator.add("//H\n1H5")
    assert_equal 7, Calculator.add("//*\n2*5")
    assert_raise Calculator::NegativesNotAllowedError do
      Calculator.add("//*\n2*-5")
    end
    assert_raise_with_message(Calculator::NegativesNotAllowedError, "negatives detected: -5") do
      Calculator.add("//*\n2*-5")
    end
    assert_raise_with_message(Calculator::NegativesNotAllowedError, "negatives detected: -5 -1 -3") do
      Calculator.add("//*\n2*-5*-1*-3")
    end
  end

end


class Calculator
  class NegativesNotAllowedError < StandardError; end

  def self.add(numbers_string)
    new.add(NumbersString.new(numbers_string))
  end

  def add(numbers_string)
    numbers_string.sum
  end

end

class NumbersString
  def initialize(value)
    @value = value
  end

  def sum
    raise_negative if negative_detected?
    numbers.inject(0, :+)
  end

  private

  def negative_detected?
    !negative.nil?
  end

  def negative
    numbers.detect { |number| number < 0 }
  end

  def raise_negative
    raise Calculator::NegativesNotAllowedError.new("negatives detected: "+negative.to_s)
  end

  def numbers
    @value.split(delimiter_regexp).map(&:to_i)
  end

  def delimiter_regexp
    return Regexp.new(Regexp.escape(delimeter)) if delimeter
    /(,|\n|H)/
  end

  def delimeter
    match = /\/\/(.)/.match(@value)
    return match[1] if match
    return false
  end
end
