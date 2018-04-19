require 'minitest/autorun'
require 'theusual'
TheUsual::load 'hash'


class HashTest < Minitest::Test

  def test_Hash
    data = {
      c: 2,
      b: 3,
      a: 1,
    }

    # Hash.map
    assert_equal(
      data,
      Hash.map(data.keys) {|x| data[x]}
    )

    assert_equal(
      {},
      Hash.map([]) {|x| nil}
    )

    assert_equal(
      { 1 => nil, 2 => nil, 3 => nil },
      Hash.map([1,2,3]) {|x| nil}
    )

    assert_equal(
      { 3 => true },
      Hash.map([1,2,3]) {|x| true if x > 2 }.compact
    )

    assert_equal(
      { 1 => [ 2, 3 ] },
      Hash.map([1]) {|x| [ 2, 3 ] }
    )

    # Hash.hmap
    assert_equal(
      { 2 => 3 },
      Hash.hmap([1]) {|x| [ 2, 3 ] }
    )

    assert_equal(
      data,
      Hash.hmap(data) {|k, v| [k, v]}
    )

    assert_equal(
      data,
      Hash.hmap(data.keys) {|x| [x, data[x]]}
    )

    assert_equal(
      { nil => 3 },
      Hash.hmap([1,2,3]) {|x| [nil, x]}
    )

    assert_equal(
      {},
      Hash.hmap([]) {|x| nil}
    )

    assert_equal(
      {},
      Hash.hmap([1, 2, 3]) {|x| nil}
    )
  end


  def test_update
    data = {
      a: 1,
      b: 2,
      c: 3,
    }

    assert_equal(
      {a: 1, b: 2, c: 3, d: 4},
      data.update({d: 4})
    )

    assert_equal(
      {a: 1, b: 2, c: 3, d: 4, e: 5},
      data.update({d: 4, e: 5})
    )

    assert_equal(
      {a: 1, b: 2, c: 3, d: 4, e: 5},
      data.update({d: 4}, {e: 5})
    )

    assert_equal(
      {a: 1, b: 2, c: 3, d: 4, e: 5},
      data.update!({d: 4}, {e: 5})
    )
    assert_equal(
      {a: 1, b: 2, c: 3, d: 4, e: 5},
      data
    )
  end


  def test_except
    data = {
      a: 1,
      b: 2,
      c: 3,
    }

    assert_equal(
      {a: 1, b: 2},
      data.except(:c)
    )

    assert_equal(
      {a: 1},
      data.except(:b, :c)
    )

    assert_equal(
      {a: 1},
      data.except!(:b, :c)
    )
    assert_equal(
      {a: 1},
      data
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

    # check alias
    assert_equal(
      {c: 2, a: 1},
      data.slice(:c, :a)
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
      data,
      data.kmap(&:to_s)
    )

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
        a: 1.0,
        b: 2.0,
        c: 3.0,
      },
      data.vmap(&:to_f)
    )

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


  def test_default_value
    data = Hash.new 123

    assert_equal(
      123,
      data.kmap {|v| nil }[:abc]
    )

    assert_equal(
      123,
      data.vmap {|v| nil }[:abc]
    )

    assert_equal(
      123,
      data.hmap {|v| nil }[:abc]
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


  def test_symbolize_keys
    assert_equal(
      {a: 1, b: 2, c: 3},
      {'a' => 1, 'b' => 2, 'c' => 3}.symbolize_keys
    )

    assert_equal(
      {a: 1, b: 2, c: { 'd' => 3 } },
      {'a' => 1, 'b' => 2, 'c' => { 'd' => 3 } }.symbolize_keys
    )

    assert_equal(
      {a: 1, b: 2, c: { z: 3 }, d: [ 'x' ] },
      {
        'a' => 1, 'b' => 2, 'c' => { 'z' => 3 }, 'd' => [ 'x' ]
      }.symbolize_keys(true)
    )


    h = {'a' => 1, 'b' => 2, 'c' => 3}
    h.symbolize_keys
    assert_equal(
      {'a' => 1, 'b' => 2, 'c' => 3},
      h
    )

    h.symbolize_keys!
    assert_equal(
      {a: 1, b: 2, c: 3},
      h
    )
  end

end
