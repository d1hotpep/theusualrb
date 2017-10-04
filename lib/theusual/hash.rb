class Hash

  class << self

    # map any Enumerable into a Hash, like Hash[obj.map ... ]
    def map(obj, &block)
      res = obj.map do |*args|
        block.call *args
      end.compact

      if res.all? {|x| x.is_a? Array and x.count == 2 }
        Hash[res]
      else
        Hash[obj.zip(res)]
      end
    end

  end # class << self


  # expand update() to accept multiple arguments
  # eg. {}.update({a: 1}, {b: 2})
  def update(*hashes)
    clone.update! *hashes
  end

  def update!(*hashes)
    hashes.each do |h|
      h.each {|k,v| self[k] = v}
    end
    self
  end


  def except(*keys)
    clone.except! *keys
  end

  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end


  def select_keys(*keys)
    if keys.length == 1 and keys.first.class < Enumerable
      keys = keys.first
    end

    Hash.map(keys) {|k| self[k] }
  end
  alias_method :slice, :select_keys

  def select_keys!(*keys)
    replace select_keys *keys
  end
  alias_method :slice!, :select_keys!


  def compact(modifier = nil)
    falsy = modifier == :falsy
    blanks = falsy || modifier == :blanks

    reject do |k, v|
      isblank = blanks && v.respond_to?(:empty?) && v.empty?
      isfalsy = falsy && (v == 0)

      !v || isblank || isfalsy
    end
  end

  def compact!(modifier = nil)
    replace compact(modifier)
  end


  # map the block's results back to a hash
  def hmap(&block)
    clone.clear.merge Hash[ map {|k, v| block.call(k, v) }.compact ]
  end

  def hmap!(&block)
    replace hmap &block
  end


  # map keys, but preserve associated values
  # ie. http://apidock.com/rails/v4.2.7/Hash/transform_keys
  def kmap(&block)
    clone.clear.merge Hash[map do |k, v|
      [ block.arity == 1 ? block.call(k) : block.call(k, v), v ]
    end]
  end

  def kmap!(&block)
    replace kmap &block
  end


  # map values, but preserve associated keys
  # ie. http://apidock.com/rails/v4.2.7/Hash/transform_values
  def vmap(&block)
    clone.vmap! &block
  end

  def vmap!(&block)
    each do |k, v|
      self[k] = block.arity == 1 ? block.call(v) : block.call(k, v)
    end
  end


  # sort by key values, for pretty printing
  def ksort(&block)
    Hash[
      sort_by do |k, v|
        if block
          yield k
        else
          k
        end
      end
    ]
  end

  def ksort!(&block)
    replace ksort &block
  end


  def vsort(&block)
    Hash[
      sort_by do |k, v|
        if block
          yield v
        else
          v
        end
      end
    ]
  end

  def vsort!(&block)
    replace vsort &block
  end


  # set like operator
  def -(other)
    raise TypeError unless other.class <= Hash
    select {|k,v| !other.has_key? k}
  end


  def symbolize_keys(deep = false)
    Hash.map each do |k, v|
      [
        k.respond_to?(:to_sym) ? k.to_sym : k,
        (deep and v.is_a?(Hash)) ? v.symbolize_keys : v
      ]
    end
  end

  def symbolize_keys!(deep = false)
    replace symbolize_keys deep
  end


  private

  # replace contents of hash with new stuff
  def replace(hash)
    clear
    merge! hash
  end

end
