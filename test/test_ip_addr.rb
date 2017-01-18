require 'minitest/autorun'
require 'theusual'
TheUsual::load 'ipaddr'


class IPAddrTest < Minitest::Test

  def test_all
    assert_equal(
      '8.8.8.8',
      IPAddr.new('8.8.8.8').to_s
    )

    assert_equal(
      '8.8.8.0',
      IPAddr.new('8.8.8.0/24').to_s
    )

    assert_equal(
      '8.8.8.0',
      IPAddr.new('8.8.8').to_s
    )

    assert_equal(
      '8.8.8',
      IPAddr.new('8.8.8.0/24').short
    )

    assert_equal(
      '8.8.8',
      IPAddr.new('8.8.8').short
    )

    assert_equal(
      '8.8.8.0',
      IPAddr.new('8.8.8.0').short
    )

    assert_equal(
      '8.8',
      IPAddr.new('8.8.8.8/16').short
    )

    # make sure this doesn't explode
    addr = IPAddr.new('8.8.8.8')
    IPAddr.new addr
  end

end
