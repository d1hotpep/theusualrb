require 'minitest/autorun'
require 'theusual'
TheUsual::load 'time'


class TimeTest < Minitest::Test

  def test_all
    assert_equal(
      'just now',
      Time.new.humanize
    )

    assert_equal(
      'a second ago',
      (Time.new - 1).humanize
    )

    assert_equal(
      '2 seconds ago',
      (Time.new - 2).humanize
    )

    assert_equal(
      'a minute ago',
      (Time.new - 60).humanize
    )
  end

end
