require 'minitest/autorun'
require 'theusual'
TheUsual::load :numeric


class NumericTest < Minitest::Test

  def test_delimiter
    # Integers
    assert_equal(
      '1,000',
      1_000.with_delimiter
    )

    assert_equal(
      '1,000,000',
      1_000_000.with_delimiter
    )

    assert_equal(
      '1_000',
      1_000.with_delimiter('_')
    )

    # Floats
    assert_equal(
      '1,000.0',
      1_000.0.with_delimiter
    )

    assert_equal(
      '1,000.123',
      1_000.123.with_delimiter
    )
  end

end
