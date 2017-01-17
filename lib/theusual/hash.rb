Hash.class_eval do
  class << self
    def symbolize_keys_deep!(h)
      return nil unless h

      h.keys.each do |k|
        ks    = k.respond_to?(:to_sym) ? k.to_sym : k
        h[ks] = h.delete k # Preserve order even when k == ks
        symbolize_keys_deep! h[ks] if h[ks].kind_of? Hash
      end

      h
    end

    # map any Enumerable into a Hash, like Hash[obj.map ... ]
    def map(obj, &block)
      Hash[
          obj.map do |*args|
            block.call *args
          end.compact
      ]
    end

    # convenience wrappers
    def sort_by(hash, &block)
      Hash[
          if block.arity == 1
            hash.sort_by do |k, v|
              block.call(v)
            end
          else
            hash.sort_by do |k, v|
              block.call(k, v)
            end
          end
      ]
    end

    def sort_by!(hash, &block)
      res = sort_by hash, &block
      hash.clear
      hash.merge! res
    end
  end # class << self


  def select_keys(*keys)
    keys = keys.first if keys.length == 1 and keys.first.is_a? Array
    Hash.map keys do |k|
      [ k, self[k] ]
    end
  end

  def select_keys!(*keys)
    hash = select_keys *keys
    clear
    merge! hash
  end

  # Allows you to get a diff between two hashes, useful when debugging API responses in the console.
  def diff(other)
    (self.keys + other.keys).uniq.inject({}) do |memo, key|
      unless self[key] == other[key]
        if self[key].kind_of?(Hash) &&  other[key].kind_of?(Hash)
          memo[key] = self[key].diff(other[key])
        else
          memo[key] = [self[key], other[key]]
        end
      end
      memo
    end
  end

  def compact(also_blanks = false)
    reject do |k,v|
      !v || (also_blanks && v.blank?)
    end

  end

  def compact!(also_blanks = false)
    hash = compact(also_blanks)
    clear
    merge! hash
  end

  # map the block's results back to a hash
  def hmap(&block)
    Hash[ map {|k, v| block.call(k, v) }.compact ]
  end

  def hmap!(&block)
    hash = hmap &block
    clear
    merge! hash
  end

  # map keys, but preserve associated values
  def kmap(&block)
    Hash[map do |k, v|
      [ block.arity == 1 ? block.call(k) : block.call(k, v), v ]
    end]

  end

  def kmap!(&block)
    hash = kmap &block
    clear
    merge! hash
  end

  # map values, but preserve associated keys
  def vmap(&block)
    Hash[map do |k, v|
      [ k, block.arity == 1 ? block.call(v) : block.call(k, v) ]
    end]
  end

  def vmap!(&block)
    merge!(vmap(&block))
  end

  # sort by key values
  def ksort
    Hash[ sort_by {|k, v| k} ]
  end

  def ksort!
    hash = kmap &block
    clear
    merge! hash
  end

  def vsort
    Hash.sort_by self do |v|
      v
    end
  end
end
