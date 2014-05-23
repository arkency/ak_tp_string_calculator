require 'test/unit'


class MainTest < Test::Unit::TestCase

  def test_calculator
    assert_equal 0, Calculator.add("")
    assert_equal 1, Calculator.add( "1")
  end

end


class Calculator
  def self.add(foo)
    0
  end

end
