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
    @value.split(delimiter_regexp).map(&:to_i).inject(0, :+)
  end

  private

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
