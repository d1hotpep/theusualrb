require 'minitest/autorun'
require 'theusual'
TheUsual::load 'time'


class TimeTest < Minitest::Test

  def test_ms
    ts = Time.now.utc

    assert(ts.to_ms.class < Integer)

    assert(
      # to_ms will truncate, so allow for small error
      ts - Time.at_ms(ts.to_ms) <= 0.001
    )
  end


  def test_humanize
    assert_equal(
      'just now',
      Time.new.humanize
    )

    assert_equal(
      'less than a minute',
      (Time.new - 50).humanize
    )

    assert_equal(
      'a second',
      (Time.new - 1).humanize(nil, seconds: true)
    )

    assert_equal(
      'a minute',
      (Time.new - 60).humanize
    )

    assert_equal(
      'an hour',
      (Time.new - 60 * 60).humanize
    )

    assert_equal(
      'an hour',
      (Time.new - 60 * 60 - 5).humanize
    )

    assert_equal(
      'about an hour',
      (Time.new - 60 * 61).humanize
    )

    assert_equal(
      'a day',
      (Time.new - 60 * 60 * 24).humanize
    )
  end

end
