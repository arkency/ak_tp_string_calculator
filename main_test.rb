require 'test/unit'


class MainTest < Test::Unit::TestCase

  def test_calculator
    assert_equal Calculator.add,  0
  end

end


class Calculator
  def self.add
    0
  end

end
