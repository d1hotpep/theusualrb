require 'minitest/autorun'
require 'theusual'


class HashTest < Minitest::Test

  def test_Hash
    data = {
      c: 2,
      b: 3,
      a: 1,
    }

    assert_equal(
      data,
      Hash.map(data.keys) {|x| [x, data[x]]}
    )

    assert_equal(
      {},
      Hash.map([]) {|x| nil}
    )

    assert_equal(
      {},
      Hash.map([1,2,3]) {|x| nil}
    )

    assert_equal(
      {nil => 3},
      Hash.map([1,2,3]) {|x| [nil, x]}
    )
  end


  def test_select_keys
    data = {
      c: 2,
      b: 3,
      a: 1,
    }

    assert_equal(
      {c: 2, a: 1},
      data.select_keys(:c, :a)
    )

    assert_equal(
      {c: 2, a: 1},
      data.select_keys([:c, :a])
    )

    assert_equal(
      {c: 2, z: nil},
      data.select_keys(:c, :z)
    )


    assert_equal(
      {c: 2, a: 1},
      data.select_keys!(:c, :a)
    )
    assert_equal(
      {c: 2, a: 1},
      data
    )
  end


  def test_compact
    data = {
      a: nil,
      b: 'b',
      c: false,
      d: '',
      e: 0,
    }

    assert_equal(
      {
        b: 'b',
        d: '',
        e: 0,
      },
      data.compact
    )

    assert_equal(
      {
        b: 'b',
        e: 0,
      },
      data.compact(:blanks)
    )

    assert_equal(
      {b: 'b'},
      data.compact(:falsy)
    )

    assert_equal(
      {b: 'b'},
      data.compact!(:falsy)
    )
    assert_equal(
      {b: 'b'},
      data
    )
  end


  def test_hmap
    data = {
      c: 2,
      b: 3,
      a: 1,
    }

    assert_equal(
      {
        c: 4,
        b: 6,
        a: 2,
      },
      data.hmap {|k,v| [k, v * 2]}
    )

    assert_equal(
      {
        cc: 4,
        bb: 6,
        aa: 2,
      },
      data.hmap {|k,v| [(k.to_s * 2).to_sym, v * 2]}
    )

    assert_equal(
      {},
      {}.hmap {|k,v| [k, v * 2]}
    )

    assert_equal(
      {},
      {a: 1}.hmap {|k,v| nil}
    )


    assert_equal(
      {
        c: 4,
        b: 6,
        a: 2,
      },
      data.hmap! {|k,v| [k, v * 2]}
    )
    assert_equal(
      {
        c: 4,
        b: 6,
        a: 2,
      },
      data
    )
  end


  def test_kmap
    data = {
      'a' => 1,
      'b' => 2,
      'c' => 3,
    }

    assert_equal(
      {
        'aa' => 1,
        'bb' => 2,
        'cc' => 3,
      },
      data.kmap {|k| k * 2}
    )

    assert_equal(
      {
        'aa' => 1,
        'bb' => 2,
        'cc' => 3,
      },
      data.kmap {|k,v| k * 2}
    )

    assert_equal(
      {
        'aa' => 1,
        'bb' => 2,
        'cc' => 3,
      },
      data.kmap! {|k,v| k * 2}
    )
    assert_equal(
      {
        'aa' => 1,
        'bb' => 2,
        'cc' => 3,
      },
      data
    )
  end


  def test_vmap
    data = {
      a: 1,
      b: 2,
      c: 3,
    }

    assert_equal(
      {
        a: 2,
        b: 4,
        c: 6,
      },
      data.vmap {|v| v * 2}
    )

    assert_equal(
      {
        a: 2,
        b: 4,
        c: 6,
      },
      data.vmap {|k,v| v * 2}
    )

    assert_equal(
      {
        a: :a,
        b: :b,
        c: :c,
      },
      data.vmap {|k,v| k}
    )


    assert_equal(
      {
        a: 2,
        b: 4,
        c: 6,
      },
      data.vmap! {|v| v * 2}
    )
    assert_equal(
      {
        a: 2,
        b: 4,
        c: 6,
      },
      data
    )
  end


  def test_ksort
    data = {
      cx: 2,
      by: 3,
      az: 1,
    }

    assert_equal(
      {
        az: 1,
        by: 3,
        cx: 2,
      }.to_a,
      data.ksort.to_a
    )

    assert_equal(
      {
        cx: 2,
        by: 3,
        az: 1,
      }.to_a,
      data.ksort {|k| k.to_s.reverse }.to_a
    )

    assert_equal(
      {
        az: 1,
        by: 3,
        cx: 2,
      },
      data.ksort!
    )
    assert_equal(
      {
        az: 1,
        by: 3,
        cx: 2,
      },
      data
    )
  end


  def test_vsort
    data = {
      c: 2,
      b: 3,
      a: 1,
    }

    assert_equal(
      {a: 1, c: 2, b: 3}.to_a,
      data.vsort.to_a
    )

    assert_equal(
      {b: 3, c: 2, a: 1}.to_a,
      data.vsort {|v| -v}.to_a
    )

    assert_equal(
      {a: 1, c: 2, b: 3}.to_a,
      data.vsort!.to_a
    )
    assert_equal(
      {a: 1, c: 2, b: 3}.to_a,
      data.to_a
    )
  end


  def test_diff
    assert_equal(
      {a: 1, b: 2, c: 3},
      {a: 1, b: 2, c: 3} - {}
    )

    assert_equal(
      {a: 1, c: 3},
      {a: 1, b: 2, c: 3} - {b: 1}
    )
  end


end

















