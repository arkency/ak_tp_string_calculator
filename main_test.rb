require 'test/unit'


class MainTest < Test::Unit::TestCase

  def test_calculator
    assert_equal 0, Calculator.add("")
    assert_equal 1, Calculator.add( "1")
    assert_equal 1.3, Calculator.add( "1,3")
  end

end


class Calculator
  def self.add(foo)
    foo.to_i
  end

end
