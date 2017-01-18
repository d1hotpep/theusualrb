require 'minitest/autorun'
require 'theusual'
TheUsual::load 'array'


class ArrayTest < Minitest::Test

  def test_sum
    assert_equal(
      6,
      [1,2,3].sum
    )
  end

  def test_avg
    assert_equal(
      2,
      [1,2,3].avg
    )

    assert_equal(
      2.5,
      [1,2,3,4].avg
    )
  end

  def test_std
    # TODO
  end

  def test_grepv
    data = ['a', 'ab', 'bab', 'bbb', 'ccc'].sort

    assert_equal(
      ['a', 'ab', 'bab'].sort,
      data.grep(/a/).sort
    )

    assert_equal(
      ['bbb', 'ccc'],
      data.grepv(/a/).sort
    )
  end

  def test_gsub
    assert_equal(
      ['a_a', '_a_'],
      ['aba', 'bab'].gsub(/b/, '_')
    )

    assert_equal(
      ['a__A'],
      ['abBA'].gsub(/b/i, '_')
    )

    res = ['aba']
    assert_equal(
      ['a_a'],
      res.gsub!(/b/, '_')
    )
    assert_equal(
      ['a_a'],
      res
    )
  end

  def test_compact
    assert_equal(
      [0, true, 'hi'],
      [0, true, 'hi'].compact
    )

    assert_equal(
      [0, ''],
      [nil, 0, false, ''].compact
    )

    assert_equal(
      [0],
      [nil, 0, false, ''].compact(:blanks)
    )

    assert_equal(
      [],
      [nil, 0, false, ''].compact(:falsy)
    )

    assert_equal(
      [1, 'a'],
      [nil, 0, false, '', 1, 'a'].compact(:falsy)
    )

    data = [nil, 0, false, '', 1, 'a']
    assert_equal(
      [1, 'a'],
      data.compact!(:falsy)
    )
    assert_equal(
      [1, 'a'],
      data.compact!(:falsy)
    )
  end

end

















