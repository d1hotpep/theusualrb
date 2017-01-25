require 'minitest/autorun'
require 'theusual'
TheUsual::load :string


class HashTest < Minitest::Test

  def test_is_i
    assert_equal(
      true,
      '1'.is_i?
    )

    assert_equal(
      true,
      '10'.is_i?
    )

    assert_equal(
      false,
      '1.0'.is_i?
    )

    assert_equal(
      true,
      '0'.is_i?
    )
  end


  def test_is_f
    assert_equal(
      false,
      '1'.is_f?
    )

    assert_equal(
      false,
      '10'.is_f?
    )

    assert_equal(
      true,
      '1.0'.is_f?
    )

    assert_equal(
      false,
      '0'.is_f?
    )

    assert_equal(
      false,
      'abc'.is_f?
    )
  end

end
