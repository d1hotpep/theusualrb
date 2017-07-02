require 'minitest/autorun'
require 'theusual'
TheUsual::load :nil


class NilTest < Minitest::Test

  def test_is_empty
    assert_equal(
      true,
      nil.empty?
    )
  end

end
