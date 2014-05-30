require 'test/unit'


class MainTest < Test::Unit::TestCase

  def test_calculator
    assert_equal 0, Calculator.add("")
    assert_equal 1, Calculator.add( "1")
    assert_equal 4, Calculator.add( "1,3")
    assert_equal 5, Calculator.add( "1,3, 1")
    assert_equal 4, Calculator.add( "1\n3")
    assert_equal 6, Calculator.add("//H\n1H5")
    #assert_equal 7, Calculator.add("//*\n2*5")
  end

end


class Calculator
  def self.add(numbers_string)
    return numbers_string.split(delimiter_regexp).map(&:to_i).inject(0, :+)
  end

  def self.delimiter_regexp
    /(,|\n|H)/
  end

end
