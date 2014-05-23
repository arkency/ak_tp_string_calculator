require 'test/unit'


class MainTest < Test::Unit::TestCase

  def test_calculator
    assert_equal 0, Calculator.add("")
    assert_equal 1, Calculator.add( "1")
    assert_equal 4, Calculator.add( "1,3")
    assert_equal 5, Calculator.add( "1,3, 1")
    assert_equal 4, Calculator.add( "1\n3")
  end

end


class Calculator
  def self.add(numbers_string)
    return numbers_string.split(/(,|\n)/).map(&:to_i).inject(0, :+)
  end

end
